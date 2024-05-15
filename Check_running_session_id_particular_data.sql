select request_session_id from sys.dm_tran_locks
where resource_database_id = DB_ID('SBI_Recovery_BLR');

