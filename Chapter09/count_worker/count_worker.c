#include "postgres.h"

/* These are always necessary for a bgworker */
#include "miscadmin.h"
#include "postmaster/bgworker.h"
#include "storage/ipc.h"
#include "storage/latch.h"
#include "storage/lwlock.h"
#include "storage/proc.h"
#include "storage/shmem.h"

/* these headers are used by this particular worker's code */
#include "access/xact.h"
#include "executor/spi.h"
#include "fmgr.h"
#include "lib/stringinfo.h"
#include "pgstat.h"
#include "utils/builtins.h"
#include "utils/snapmgr.h"
#include "tcop/utility.h"

PG_MODULE_MAGIC;

void		_PG_init(void);
void    worker_main(Datum) pg_attribute_noreturn();

/* flags set by signal handlers */
static volatile sig_atomic_t sigterm_activated = false;



static void
sighup_handler( SIGNAL_ARGS )
{
	int	caught_errno = errno;
	if (MyProc)
		SetLatch(&MyProc->procLatch);

  /* restore original errno */
	errno = caught_errno;
}

static void
sigterm_handler( SIGNAL_ARGS )
{
  sighup_handler( postgres_signal_arg );
  sigterm_activated = true;
}


 void
worker_main( Datum main_arg )
{

	StringInfoData queryStringData;
	initStringInfo( &queryStringData );


  char *log_table_database = "testdb";
  char *log_table_schema   = "public";
  char *log_table_name     = "log";
  char *log_table_message  = "STILL ALIVE and counting!";
  char *log_username       = "luca";
  int  log_entry_counter   = 0;



	elog( DEBUG1, "starting counter_worker::worker_main" );



	pqsignal( SIGHUP,  sighup_handler );
	pqsignal( SIGTERM, sigterm_handler );
  sigterm_activated = false;
	BackgroundWorkerUnblockSignals();

	BackgroundWorkerInitializeConnection( log_table_database,
                                        log_username,
                                        0 );

	/*
	 * Main loop: do this until the SIGTERM handler tells us to terminate
	 */
	while ( ! sigterm_activated )
	{
		int	ret;
		int	rc;

    elog( DEBUG1, "counter_worker in main loop" );

		rc = WaitLatch( &MyProc->procLatch,
					          WL_LATCH_SET | WL_TIMEOUT | WL_POSTMASTER_DEATH,
                    10000L,
                    PG_WAIT_EXTENSION ); /* 10 seconds */
		ResetLatch( &MyProc->procLatch );

		if ( rc & WL_POSTMASTER_DEATH )
			proc_exit( 1 );


		SetCurrentStatementStartTimestamp();
		StartTransactionCommand();
		SPI_connect();
		PushActiveSnapshot( GetTransactionSnapshot() );
		pgstat_report_activity( STATE_RUNNING, queryStringData.data );

		resetStringInfo( &queryStringData );
		appendStringInfo( &queryStringData,
                      "INSERT INTO %s.%s( message ) "
                      "VALUES( '%s %d' ) ",
                      log_table_schema,
                      log_table_name,
                      log_table_message,
                      ++log_entry_counter );


		elog( DEBUG1, "counter_worker executing query [%s] by [%s]",
          queryStringData.data,
          log_username );

		ret = SPI_execute( queryStringData.data, /* query to execute */
                       false,                /* not readonly query */
                       0 );                  /* no count limit */

		if ( ret != SPI_OK_INSERT )
			elog( FATAL, "counter_worker cannot execute query, error code [%d]", ret );


		SPI_finish();
		PopActiveSnapshot();
		CommitTransactionCommand();
		pgstat_report_activity( STATE_IDLE, NULL );
	}

	proc_exit(0);
}


void
_PG_init(void)
{
	BackgroundWorker worker;

	/* set up worker data */
	worker.bgw_flags         = BGWORKER_SHMEM_ACCESS
                             | BGWORKER_BACKEND_DATABASE_CONNECTION;
	worker.bgw_start_time    = BgWorkerStart_RecoveryFinished;
	worker.bgw_restart_time  = BGW_NEVER_RESTART;
	snprintf( worker.bgw_name, BGW_MAXLEN, "counter worker" );
  snprintf( worker.bgw_function_name, BGW_MAXLEN, "worker_main" );
  snprintf( worker.bgw_library_name, BGW_MAXLEN, "count_worker" );
  worker.bgw_notify_pid    = 0;

  elog( INFO, "counter_worker::_PG_init registering worker [%s]", worker.bgw_name );

	/* register worker */
	RegisterBackgroundWorker(&worker);
}
