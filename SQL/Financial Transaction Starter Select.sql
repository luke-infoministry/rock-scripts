/*
Created 8/18/2023
A starter select query for financial transactions
*/

SELECT TOP 10
    ftd.[Id] AS [DetailId]
    , ftd.[Amount]
    , ftd.[FeeAmount]
    , ftd.[FeeCoverageAmount]
    , ft.[Id] AS [TransactionId]
    , ft.[TransactionCode]
    , tt.[Value] AS [TransactionType]
    , st.[Value] AS [SourceType]
    , ft.[TransactionDateTime]
    , ft.[CreatedDateTime]
    , ft.[ModifiedDatetime]
    , CONCAT(ct.[Value], 
        CASE 
            WHEN cc.[Value] <> '' THEN ' (' + cc.[Value] + ') ' 
            WHEN nc.[Value] <> '' THEN ' (' + nc.[Value] + ') ' 
            END) AS [CurrencyType]
    , sch.[Id] AS [ScheduledTransactionId]
    , fa.[Id] AS [AccountId]
    , fa.[Name] AS [Account]
    , fa.[PublicName] AS [AccountPublic]
    , fa.[IsTaxDeductible]
    , fb.[Id] AS [BatchId]
    , fb.[Name] AS [BatchName]
    , bc.[Id] AS [BatchCampusId]
    , bc.[Name] AS [BatchCampus]
    , fg.[Id] AS [GatewayId]
    , fg.[Name] AS [Gateway]
    , fb.[BatchStartDateTime]
    , fb.[BatchEndDatetime]
    , p.[Id] AS [PersonId]
    , CONCAT(p.[FirstName], ' ',
        CASE WHEN p.[NickName] != p.[FirstName] THEN '(' + p.[NickName] + ') ' END,
        p.[LastName]) AS [Person]
    , p.[Email]
    , pc.[Id] AS [PersonCampusId]
    , pc.[Name] AS [PersonCampus]
FROM
    [FinancialTransactionDetail] ftd
    INNER JOIN [FinancialTransaction] ft ON ft.[Id] = ftd.[TransactionId]
    INNER JOIN [FinancialPaymentDetail] fpd ON fpd.[Id] = ft.[FinancialPaymentDetailId]
    INNER JOIN [FinancialAccount] fa ON fa.[Id] = ftd.[AccountId]
    INNER JOIN [FinancialBatch] fb ON fb.[Id] = ft.[BatchId]
    INNER JOIN [PersonAlias] pa ON pa.[Id] = ft.[AuthorizedPersonAliasId]
    INNER JOIN [Person] p ON p.[Id] = pa.[PersonId]
    LEFT OUTER JOIN [DefinedValue] tt ON tt.[Id] = ft.[TransactionTypeValueId]
    LEFT OUTER JOIN [DefinedValue] st ON st.[Id] = ft.[SourceTypeValueId]
    LEFT OUTER JOIN [DefinedValue] cc ON cc.[Id] = fpd.[CreditCardTypeValueId]
    LEFT OUTER JOIN [DefinedValue] ct ON ct.[Id] = fpd.[CurrencyTypeValueId]
    LEFT OUTER JOIN [DefinedValue] nc ON nc.[Id] = ft.[NonCashAssetTypeValueId]
    LEFT OUTER JOIN [FinancialScheduledTransaction] sch ON sch.[Id] = ft.[ScheduledTransactionId]
    LEFT OUTER JOIN [FinancialGateway] fg ON fg.[Id] = ft.[FinancialGatewayId]
    LEFT OUTER JOIN [Campus] bc ON bc.[Id] = fb.[CampusId]
    LEFT OUTER JOIN [Campus] pc ON pc.[Id] = p.[PrimaryCampusId]
