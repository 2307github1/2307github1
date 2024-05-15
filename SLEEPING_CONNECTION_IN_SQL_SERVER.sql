SELECT * 
FROM sys.dm_exec_sessions 
WHERE status = N'sleeping' AND open_transaction_count = 0 AND is_user_process = 1;
