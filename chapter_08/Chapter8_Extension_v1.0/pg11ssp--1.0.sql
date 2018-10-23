CREATE TABLE IF NOT EXISTS files (
   pk int GENERATED ALWAYS AS IDENTITY,
   f_name text NOT NULL,
   f_size numeric(10,4) DEFAULT 0,
   f_hash text NOT NULL DEFAULT 'N/A',
   f_type text DEFAULT 'txt',
   ts timestamp DEFAULT now(),

   PRIMARY KEY ( pk ),
   UNIQUE ( f_hash ),
   CHECK ( f_size >= 0 )
);

CREATE TABLE IF NOT EXISTS tags(
   pk int GENERATED ALWAYS AS IDENTITY,
   t_name text NOT NULL,
   t_child_of int,

   PRIMARY KEY ( pk ),
   FOREIGN KEY ( t_child_of )
   REFERENCES tags( pk ),

   -- do not allow the same name in the same
   -- part of the tree
   UNIQUE( t_name, t_child_of )
);

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
