

SELECT * into #tblA
FROM information_schema.columns
WHERE table_Schema ='dbo' and table_name = 'INBOUND_IVR_MOTOR_backup' ;

SELECT * into #tblB
FROM information_schema.columns
WHERE table_Schema ='dbo' and table_name = 'INBOUND_IVR_MOTOR' ;

SELECT
COALESCE(A.Column_Name, B.Column_Name) AS [Column]
,CASE 
WHEN (A.Column_Name IS NULL and B.Column_Name IS NOT NULL)
THEN 'Column - [' + B.Column_Name+ '] exists in Table - ['+ B.TABLE_NAME + '] Only'
WHEN (B.Column_Name IS NULL and A.Column_Name IS NOT NULL)
THEN 'Column - [' + A.Column_Name+ '] exist in Table - ['+ A.TABLE_NAME + '] Only'
WHEN A.Column_Name = B.Column_Name
THEN 'Column - [' + A.Column_Name + '] exists in both Table - ['+ A.TABLE_NAME + ' , ' + B.TABLE_NAME + ']'
END AS Remarks
FROM #tblA A
FULL JOIN #tblB B ON A.Column_Name = B.Column_Name;

drop table #tblA;
drop table #tblB;


