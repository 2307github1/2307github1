

select a.dbid,b.name, count(a.dbid) as TotalConnections
from sys.sysprocesses a
inner join sys.databases b on a.dbid = b.database_id
group by a.dbid, b.name order by TotalConnections desc


select request_session_id , * from sys.dm_tran_locks 
where resource_database_id = db_id('icici_card_collection')


SELECT * FROM sys.dm_exec_sessions WHERE status = N'sleeping'
AND open_transaction_count = 0 AND is_user_process = 1 order by login_time desc;

select * from master.dbo.sysprocesses where
spid = 366




select * from sys.tcp_endpoints
 