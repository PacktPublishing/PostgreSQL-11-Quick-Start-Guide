DO
 $code$
 BEGIN
   -- do stuff
   ...
   RAISE
         USING
         ERRCODE = 'unique_violation',
         HINT = 'You should check your unique constraints',
         DETAIL = 'Cannot insert duplicated hash values!',
         MESSAGE = 'Cannot proceed further';
 END
 $code$;
