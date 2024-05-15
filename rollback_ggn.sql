USE [ICICI_CARD_COLLECTION_GGN]
GO
/****** Object:  StoredProcedure [dbo].[Get_InputMasterManual_Data_ICICICC]    Script Date: 11-07-2023 14:50:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[Get_InputMasterManual_Data_ICICICC]  --'getCustInfoManual','OPO085621'
@Operation varchar(20),
@AgentID varchar(20)
--@Disposition varchar(50),
--@Subdisposition varchar(50)

AS
BEGIN
If(@Operation = 'getCustInfoManual')
Begin


Select Mycode,Sum(Attempt) attempt into #temp From History_Attempt nolock
where convert(varchar,Disposetime,112) = convert(varchar,getdate(),112)
Group by MyCode having Sum(Attempt) < 15


Select  H.Mycode,T.Attempt,CASE WHEN H.REMARKS = 'Dialer Disposition' then H.remarks else H.Disposition end Disposition ,
CASE WHEN H.REMARKS = 'Dialer Disposition' then H.remarks else H.Subdisposition end Subdisposition,
I.ACB_BILL_CYCLE as Cycle,
I.PYD_PMT_TOT_AMT_DUE as TotalDue,
[PYD_PMT_PAST_DUE] as MinimumDue,
cast(I.[FULL_NAME] as varchar(50)) as CustomerName,
I.[CUS_CITY] as City,
cast(I.[ACCT] as varchar(50)) acct
into #tempfd
From History_Attempt H(NOLOCK) inner join #temp T on H.Mycode = T.Mycode inner Join Input_master I(NOLOCK) on I.Mycode = H.Mycode
where  H.ID in (Select MAX(ID) from History_Attempt (NOLOCK) where Mycode in (
Select Mycode From #temp) group by mycode) and DATEADD(Mi,15,Disposetime) < getdate()



select * from #tempfd H where acct in (select acct from Input_master_manual where agentid = @AgentID)--H.Mycode in (select mycode from input_master where  convert(varchar(50),acct) in (Select acct from INPUT_MASTER_Manual where Agentid = @AgentID)) 

UNION

Select Mycode,'0' Attempt,'' Disposition,'' SubDisposition,I.ACB_BILL_CYCLE as Cycle,I.PYD_PMT_TOT_AMT_DUE as TotalDue,[PYD_PMT_PAST_DUE] as MinimumDue,cast(I.[FULL_NAME] as varchar(50)) as CustomerName,I.[CUS_CITY] as City,cast(I.[ACCT] as varchar(50)) acct From Input_Master I where
cast(Acct as varchar) in (Select acct from INPUT_MASTER_Manual(NOLOCK) where Agentid = @AgentID)
and Mycode not in (Select Mycode from History_Attempt(NOLOCK))


--Select H.Id,H.Mycode,0 Attempt,CASE WHEN H.REMARKS = 'Dialer Disposition' then H.remarks else H.Disposition end Disposition ,
--CASE WHEN H.REMARKS = 'Dialer Disposition' then H.remarks else H.Subdisposition end Subdisposition,
--I.ACB_BILL_CYCLE as Cycle,
--I.PYD_PMT_TOT_AMT_DUE as TotalDue,
--[PYD_PMT_PAST_DUE] as MinimumDue,
--cast(I.[FULL_NAME] as varchar(50)) as CustomerName,
--I.[CUS_CITY] as City,
--cast(I.[ACCT] as varchar(50)) acct from History_Attempt H, Input_Master I where 1<>1

END
If(@Operation = 'ShowCustInfoManual')
BEGIN



Select H.Id,H.Mycode,0 Attempt,CASE WHEN H.REMARKS = 'Dialer Disposition' then H.remarks else H.Disposition end Disposition ,
CASE WHEN H.REMARKS = 'Dialer Disposition' then H.remarks else H.Subdisposition end Subdisposition,
I.ACB_BILL_CYCLE as Cycle,
I.PYD_PMT_TOT_AMT_DUE as TotalDue,
[PYD_PMT_PAST_DUE] as MinimumDue,
cast(I.[FULL_NAME] as varchar(50)) as CustomerName,
I.[CUS_CITY] as City,
cast(I.[ACCT] as varchar(50)) acct from History_Attempt H, Input_Master I where 1<>1
END
	
	
	
	
					
END
