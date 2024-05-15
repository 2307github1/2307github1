select top 50 DB_NAME(t.[dbid]) as [database_name],
replace (replace(left(t.[text],255), char(10),''),char(13),'') as short_query_text,
qs.total_worker_time as total_worker_time, qs.min_worker_time as min_worker_time,
qs.total_worker_time/qs.execution_count as avg_worker_time,
qs.max_worker_time as max_worker_time,
qs.min_elapsed_time as min_elapsed_time,
qs.total_elapsed_time/qs.execution_count as avg_elapsed_time,
qs.max_elapsed_time as max_elapsed_time,
qs.min_logical_reads/qs.execution_count as avg_logical_reads,
qs.max_logical_reads as min_logical_reads,
qs.execution_count as execution_count , qs.creation_time as creation_time

from sys.dm_exec_query_stats as qs with(nolock)
cross apply sys.dm_exec_sql_text(plan_handle) as t
cross apply sys.dm_exec_query_plan(plan_handle) as qp
order by qs.total_worker_time desc option (recompile)