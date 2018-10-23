CREATE EVENT TRIGGER
etr_avoid_drop_function
ON sql_drop
EXECUTE PROCEDURE f_etr_avoid_drop_function_plperl();
