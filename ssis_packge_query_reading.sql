;WITH XMLNAMESPACES ('www.microsoft.com/SqlServer/Dts' AS  
DTS,'www.microsoft.com/sqlserver/dts/tasks/sqltask' AS SQLTask) 

-- Query to Extract SQL Tasks with Name and SQL Statement 
SELECT Pkg.props.value('../../DTS:Property[@DTS:Name="ObjectName"]
[1]','varchar(MAX)') ObjectName, 
Pkg.props.value('(@SQLTask:SqlStatementSource)[1]', 'NVARCHAR(MAX)') AS 
SqlStatement FROM (select cast(pkgblob.BulkColumn as XML) pkgXML from 
openrowset(bulk 'D:\SSIS_Projects\SSISImportMySQLTOSQL_CHN_SBICARD_172.19.11.62\SSISImportMySQLTOSQL\ImportMySQLToSQL_CHN.dtsx',single_blob) 
as pkgblob) t CROSS APPLY pkgXML.nodes('//DTS:ObjectData//SQLTask:SqlTaskData') Pkg(props) 
UNION 

-- Query to Extract DTS Pipline task with Name and SqlCommand 

SELECT Pkg.props.value('../../../../DTS:Property[@DTS:Name="ObjectName"]
[1]','varchar(MAX)') ObjectName, 
Pkg.props.value('data(./properties/property[@name=''SqlCommand''])[1]', 
'varchar(max)') SqlStatement FROM(select cast(pkgblob.BulkColumn as XML) 
 pkgXML from openrowset(bulk 'D:\SSIS_Projects\SSISImportMySQLTOSQL_CHN_SBICARD_172.19.11.62\SSISImportMySQLTOSQL\ImportMySQLToSQL_CHN.dtsx',single_blob) as pkgblob) t CROSS APPLY 
pkgXML.nodes('//DTS:Executable//pipeline//components//component') Pkg(props) 
WHERE Pkg.props.value('data(./properties/property[@name=''SqlCommand''])
[1]', 'varchar(max)') <>''
