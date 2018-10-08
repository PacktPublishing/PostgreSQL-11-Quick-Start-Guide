CREATE TABLE IF NOT EXISTS j_files_tags (
   pk int GENERATED ALWAYS AS IDENTITY,
   f_pk int,
   t_pk int,

   PRIMARY KEY ( pk ),
   -- do not allow the same tag on the same file twice!
   UNIQUE( f_pk, t_pk ),

   FOREIGN KEY ( f_pk ) REFERENCES files( pk ),
   FOREIGN KEY ( t_pk ) REFERENCES tags( pk )
);
