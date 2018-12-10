CREATE TABLE IF NOT EXISTS playlist (
       pk int GENERATED ALWAYS AS IDENTITY,
       p_name text NOT NULL,

       PRIMARY KEY ( pk )
);
