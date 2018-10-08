UPDATE files
SET
   f_repo.repo_protocol = 'file',
   f_repo.repo_url = '/packt/code/files/'
WHERE f_type = 'txt';
