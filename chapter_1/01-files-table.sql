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
