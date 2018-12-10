CREATE OR REPLACE FUNCTION
f_url_to_repository( url text,
                     branch text DEFAULT 'master' )
RETURNS t_repository
AS
  $code$
  DECLARE
    repo t_repository;
    parts text[];
  BEGIN
    -- extract URL information
     parts := string_to_array( url, '://' );
     repo.repo_protocol := parts[ 1 ];

     -- extact all is before the commit part
     parts := string_to_array( parts[ 2 ], '/commit' );
     repo.repo_url := parts[ 1 ];

     -- if we have a commit, set also the branch
     IF parts[ 2 ] IS NOT NULL AND length( parts[ 2 ] ) > 0 THEN
          repo.repo_commit := parts[ 2 ];
          repo.repo_branch := branch;
     END IF;

     RETURN repo;
  END
  $code$
LANGUAGE plpgsql
STRICT;
