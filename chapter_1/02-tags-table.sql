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
