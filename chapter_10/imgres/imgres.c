#include "postgres.h"
#include "fmgr.h"
#include <math.h>

PG_MODULE_MAGIC;

/*
 * define the pattern used to convert to
 * and from a text representation
 */
#define TEXT_PATTERN    "<%d x %d @ %d dpi>"
#define TEXT_PATTERN_IN "%d %d %d"

typedef struct ImgRes
{
  unsigned int h_px;            /* horizontal pixels */
  unsigned int v_px;            /* vertical pixels */
  unsigned int dpi;             /* resolution */

} ImgRes;


/*
 * Create a new ImgRes initialized with default values.
 */
ImgRes* new_ImgRes() {
  ImgRes* new_object = (ImgRes*) palloc( sizeof( ImgRes ) );
  new_object->h_px = 300;
  new_object->v_px = 300;
  new_object->dpi  = 96;
  return new_object;
}


/*
 * Convert the ImgRes to a string.
 * Returns a string like "<300 x 300 @ 96 dpi>"
 */
char* to_string( ImgRes* object ){
  return psprintf( TEXT_PATTERN,
                   object->h_px,
                   object->v_px,
                   object->dpi );
}



PG_FUNCTION_INFO_V1( imgres_input_function );

Datum imgres_input_function( PG_FUNCTION_ARGS ) {

  /* get the textual represntation */
	char	 *input_string = PG_GETARG_CSTRING(0);
  /* create a new object */
  ImgRes *object       = new_ImgRes();


  /* try to convert the text into an object */
  int matches = sscanf( input_string,
                        TEXT_PATTERN,
                        &object->h_px,
                        &object->v_px,
                        &object->dpi );
	if ( matches != 3 )
    matches = sscanf( input_string,
                      TEXT_PATTERN_IN,
                      &object->h_px,
                      &object->v_px,
                      &object->dpi );
  if ( matches != 3 )
		ereport(ERROR,
				(errcode(ERRCODE_INVALID_TEXT_REPRESENTATION),
				 errmsg("invalid input syntax for imgres: \"%s\"",	input_string ) ) );

	PG_RETURN_POINTER( object );
}

PG_FUNCTION_INFO_V1( imgres_output_function );

Datum imgres_output_function( PG_FUNCTION_ARGS ) {
  /* get the object */
  ImgRes *object = (ImgRes*) PG_GETARG_POINTER(0);
	PG_RETURN_CSTRING( to_string( object ) );
}

/*****************************************************************************
 * New Operators
 *
 * A practical Complex datatype would provide much more than this, of course.
 *****************************************************************************/

PG_FUNCTION_INFO_V1( imgres_add );

Datum imgres_add(PG_FUNCTION_ARGS) {

  ImgRes *first  = (ImgRes*) PG_GETARG_POINTER(0);
  ImgRes *second = (ImgRes*) PG_GETARG_POINTER(1);

  /* check the resolution is the same */
  if ( first->dpi != second->dpi )
		ereport(ERROR,
            (errcode(ERRCODE_INVALID_TEXT_REPRESENTATION),
             errmsg("Cannot add an image with resolution %d to one with resolution %d dpi",
                    first->dpi, second->dpi ) ) );

  ImgRes *sum    = new_ImgRes();
  sum->h_px = first->h_px + second->h_px;
  sum->v_px = first->v_px + second->v_px;
  sum->dpi  = first->dpi;
	PG_RETURN_POINTER( sum );
}


PG_FUNCTION_INFO_V1( imgres_equals );

Datum imgres_equals( PG_FUNCTION_ARGS ) {
  ImgRes *first  = (ImgRes*) PG_GETARG_POINTER(0);
  ImgRes *second = (ImgRes*) PG_GETARG_POINTER(1);

  PG_RETURN_BOOL( first->dpi == second->dpi
                  && first->h_px == second->h_px
                  && first->v_px == second->v_px );
}


PG_FUNCTION_INFO_V1( imgres_not_equals );

Datum imgres_not_equals( PG_FUNCTION_ARGS ) {
  PG_RETURN_BOOL( ! imgres_equals( fcinfo ) );
}
