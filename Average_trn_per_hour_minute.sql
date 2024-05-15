DECLARE       @Days  INT

Declare       @Last_Restarted_Date DATETIME;

SELECT @Days=DATEDIFF(D,sqlserver_start_time, GETDATE()),
       @Last_Restarted_Date= sqlserver_start_time
                     FROM sys.dm_os_sys_info

SELECT @Days = CASE WHEN @Days = 0 THEN 1 ELSE @Days END; 

/*** Get total transactions occurred in SQL Server Instance since last restart ***/

SELECT  @Last_Restarted_Date   AS 'SQL Server Restart TimeStamp',
             @@SERVERNAME      AS 'Instance Name',
             cntr_value        AS 'Total Transactions Since Last Restart',
             cntr_value / @Days  AS 'Avg Transactions\Day',
             cntr_value / (@Days*24) AS 'Avg Transactions\Hour',
             cntr_value / (@Days*24*60) AS 'Avg Transactions\Min',
             cntr_value / (@Days*24*60*60)     AS 'Avg Transactions\Sec'
FROM    sys.dm_os_performance_counters
WHERE   counter_name = 'Transactions/sec'
        AND instance_name = '_Total';
