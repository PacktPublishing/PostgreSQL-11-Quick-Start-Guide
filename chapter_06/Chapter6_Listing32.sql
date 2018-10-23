CREATE EVENT TRIGGER
etr_avoid_drop_function
ON sql_drop
WHEN  TAG IN ( 'DROP FUNCTION' )
EXECUTE PROCEDURE f_etr_avoid_drop_function();
