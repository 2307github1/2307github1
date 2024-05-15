select request_session_id , * from sys.dm_tran_locks 
where resource_database_id = db_id('TTL_SME')
