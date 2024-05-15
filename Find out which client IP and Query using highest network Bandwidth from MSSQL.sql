
 select t.hostname as 'Host Name', t.login_time as 'Login Time', substring(q.text,1,200) as 'CommandExecuted',sum(p.total_rows)*8 as'KBTransffered' ,
 t.waittime as 'Wait Time',t.lastwaittype as 'Last Wait Type',t.last_batch as 'Last Batch', t.PROGRAM_NAME as 'Program Name', t.hostprocess as 'Host Process Name', 
 t.nt_domain as 'Domain Name', t.nt_username as 'Domain User Name', t.net_address as 'Net Address', t.loginame as 'LoginName' 
 from sysprocesses t inner join sys.dm_exec_query_stats p on p.sql_handle = t.sql_handle cross apply sys.dm_exec_sql_text(t.sql_handle) as q Group by t.hostname,
  t.login_time, q.text,p.total_rows, t.waittime ,t.lastwaittype, t.last_batch, t.PROGRAM_NAME,t.hostprocess,t.nt_domain, t.nt_username, t.net_address, t.loginame
