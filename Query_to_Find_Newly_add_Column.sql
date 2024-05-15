
 SELECT
    OBJECT_NAME(sc.[object_id]) as [table]
    ,sc.[name] as [column]
    ,so.modify_date
    ,so.create_date
  FROM [sys].[columns] sc
  JOIN [sys].[objects] so
  ON sc.[object_id] = so.[object_id]
  ORDER BY so.modify_date DESC, so.create_date ASC






