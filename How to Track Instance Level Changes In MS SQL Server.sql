--- use master
---drop table [SQLskills_ConfigData]

IF OBJECT_ID(N'dbo.SQLskills_ConfigData', N'U') IS NULL
  CREATE TABLE [dbo].[SQLskills_ConfigData] 
  (
    [ConfigurationID] [int] NOT NULL ,
    [Name] [nvarchar](35) NOT NULL ,
    [Value] [sql_variant] NULL ,
    [ValueInUse] [sql_variant] NULL ,
    [CaptureDate] [datetime] NOT NULL DEFAULT SYSDATETIME()
  ) ON [PRIMARY];
GO
CREATE CLUSTERED INDEX [CI_SQLskills_ConfigData] 
  ON [dbo].[SQLskills_ConfigData] ([CaptureDate],[ConfigurationID]);
GO

/* Statements to use in scheduled job */

INSERT INTO [dbo].[SQLskills_ConfigData]
(
  [ConfigurationID] ,
  [Name] ,
  [Value] ,
  [ValueInUse]
)
SELECT 
  [configuration_id] ,
  [name] ,
  [value] ,
  [value_in_use]
FROM [sys].[configurations];
GO

;WITH [f] AS
( 
  SELECT
    ROW_NUMBER() OVER (PARTITION BY [ConfigurationID] ORDER BY [CaptureDate] ASC) AS [RowNumber],
    [ConfigurationID] AS [ConfigurationID],
    [Name] AS [Name],
    [Value] AS [Value],
    [ValueInUse] AS [ValueInUse],
    [CaptureDate] AS [CaptureDate]
  FROM [master].[dbo].[SQLskills_ConfigData]
)
SELECT 
  [f].[Name] AS [Setting], 
  [f].[CaptureDate] AS [Date], 
  [f].[Value] AS [Previous Value], 
  [f].[ValueInUse] AS [Previous Value In Use],
  [n].[CaptureDate] AS [Date Changed], 
  [n].[Value] AS [New Value], 
  [n].[ValueInUse] AS [New Value In Use]
FROM [f]
LEFT OUTER JOIN [f] AS [n]
ON [f].[ConfigurationID] = [n].[ConfigurationID]
AND [f].[RowNumber] + 1 = [n].[RowNumber]
WHERE ([f].[Value] <> [n].[Value] OR [f].[ValueInUse] <> [n].[ValueInUse]);
GO