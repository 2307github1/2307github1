DECLARE @TableRowCounts TABLE ([TableName] VARCHAR(128), [RowCount] INT) ;
INSERT INTO @TableRowCounts ([TableName], [RowCount])
EXEC sp_MSforeachtable 'SELECT ''?'' [TableName], COUNT(*) [RowCount] FROM ?' ;
SELECT [TableName], [RowCount]
FROM @TableRowCounts
ORDER BY [TableName]
GO
 



---dbcc sqlperf(logspace)


---select name, log_reuse_wait_desc from sys.databases where name='Edelweiss_LMS'

