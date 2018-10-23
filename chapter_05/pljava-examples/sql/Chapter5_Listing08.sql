CREATE OR REPLACE FUNCTION f_j_split_tag_to_string( text, text )
RETURNS SETOF text
AS
  'pg11ssp.Functions.splitTagString'
LANGUAGE java;
