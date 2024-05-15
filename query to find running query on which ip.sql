

SELECT r.client_net_address,sqltext.Text
  FROM sys.dm_exec_requests req left join sys.dm_exec_connections as r on req.session_id=r.session_id
CROSS APPLY sys.dm_exec_sql_text(sql_handle) AS sqltext
