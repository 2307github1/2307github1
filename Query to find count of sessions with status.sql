SELECT status, count(*) no_of_session
FROM   sys.dm_exec_sessions group by status;

