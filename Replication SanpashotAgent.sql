


select  immediate_sync,allow_anonymous , * from distribution. dbo.MsPublications 



use ICICI_CARD_COLLECTION_BLR
Exec Sp_Changepublication 
@publication ='ICICI_CARD_COLLECTION_BLR',
@property =N'allow_anonymous',
@value ='True'


use ICICI_CARD_COLLECTION_BLR
Exec Sp_Changepublication 
@publication ='ICICI_CARD_COLLECTION_BLR',
@property =N'immediate_sync',
@value ='True'

