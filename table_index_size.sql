--This part of the script creates temporary table, 
--which will hold results of sp_spaceused execution for each table
CREATE TABLE #IxSizes(TableName nvarchar(128),
NumberOfRows varchar(50),ReservedSpace varchar(50),
TableDataSpace varchar(50),IndexSize varchar(50),
unused varchar(50))
EXEC sp_msforeachtable 
'insert into #IxSizes exec sp_spaceused [?]'
GO
--Filtering the result set to show only table names, their dedicated 
--spaces within a database and indexes for each of tables
SELECT TableName AS [Table], IndexSize AS [Total indexes size] 
FROM #IxSizes
ORDER BY TableName DESC
GO
DROP TABLE #IxSizes
GO