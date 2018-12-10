CREATE TYPE imgres;

CREATE OR REPLACE FUNCTION
imgres_input_function( cstring )
RETURNS imgres
AS 'imgres.so'
LANGUAGE C IMMUTABLE STRICT;


CREATE OR REPLACE FUNCTION
imgres_output_function( imgres )
RETURNS cstring
AS 'imgres.so'
LANGUAGE C IMMUTABLE STRICT;


CREATE TYPE imgres (
  input          = imgres_input_function,
  output         = imgres_output_function,
  internallength = 16,
  alignment      = double
);


CREATE FUNCTION imgres_add( imgres, imgres )
RETURNS imgres
AS 'imgres.so'
LANGUAGE C IMMUTABLE STRICT;

CREATE OPERATOR + (
  leftarg    = imgres,
  rightarg   = imgres,
  procedure  = imgres_add,
  commutator = +
);


CREATE FUNCTION imgres_equals( imgres, imgres )
RETURNS bool
AS 'imgres.so'
LANGUAGE C IMMUTABLE STRICT;

CREATE OPERATOR = (
  LEFTARG    = imgres,
  RIGHTARG   = imgres,
  PROCEDURE  = imgres_equals,
  COMMUTATOR = =
);




CREATE FUNCTION imgres_not_equals( imgres, imgres )
RETURNS bool
AS 'imgres.so'
LANGUAGE C IMMUTABLE STRICT;

CREATE OPERATOR <> (
LEFTARG    = imgres,
RIGHTARG   = imgres,
PROCEDURE  = imgres_not_equals,
COMMUTATOR = <>
);
