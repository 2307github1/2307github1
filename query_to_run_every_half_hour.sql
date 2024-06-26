select SUBSTRING(qt.text ,(qs.statement_start_offset/2)+1,
((case qs.statement_end_offset when -1 then DATALENGTH(qt.text)
else
qs.statement_end_offset ENd 
- qs.statement_start_offset)/2)+1) as [TEXT],
qs.execution_count,
qs.total_logical_reads,qs.last_logical_reads,
qs.total_logical_writes,qs.last_logical_writes,
qs.total_worker_time,
qs.total_elapsed_time/1000000 toatal_elapsed_time_in_S,
qs.last_elapsed_time/1000000 last_elapsed_time_in_s,
qs.last_execution_time,
qp.query_plan from sys.dm_exec_query_stats qs
cross apply sys.dm_exec_sql_text(qs.sql_handle) qt
 cross apply sys.dm_exec_query_plan(qs.plan_handle)qp
 order by qs.total_worker_time desc