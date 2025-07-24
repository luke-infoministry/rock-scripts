-- =====================================================================================================
-- Author:	Luke Taylor
-- Create Date:	Jul 24, 2025
-- Description: This query will look for double ampersands in {% if %} Lava in  Html Content 
--
-- Change History:
--   
-- =====================================================================================================

SELECT
    p.[Id]
    , p.[InternalName]
    , b.[Id] AS [BlockId]
    , b.[Name] AS [Block]
    , hc.[Id] AS [ContentId]
    , hc.[Version]
    , hc.[Content]
FROM [HtmlContent] hc
INNER JOIN [Block] b ON b.[Id] = hc.[BlockId]
INNER JOIN [Page] p ON p.[Id] = b.[PageId]
WHERE
    -- find {% if or {%- if
    (CHARINDEX('{% if', [Content]) > 0 OR CHARINDEX('{%- if', [Content]) > 0)
    AND CHARINDEX('&&', [Content]) > 0
    AND (
        -- check for && between opening tag and closing tag, including -%}
        (
            CHARINDEX('{% if', [Content]) > 0
            AND CHARINDEX('&&', [Content]) > CHARINDEX('{% if', [Content])
            AND CHARINDEX('&&', [Content]) < 
                ISNULL(NULLIF(CHARINDEX('%}', [Content], CHARINDEX('{% if', [Content])), 0),
                       CHARINDEX('-%}', [Content], CHARINDEX('{% if', [Content])))
        )
        OR
        (
            CHARINDEX('{%- if', [Content]) > 0
            AND CHARINDEX('&&', [Content]) > CHARINDEX('{%- if', [Content])
            AND CHARINDEX('&&', [Content]) < 
                ISNULL(NULLIF(CHARINDEX('%}', [Content], CHARINDEX('{%- if', [Content])), 0),
                       CHARINDEX('-%}', [Content], CHARINDEX('{%- if', [Content])))
        )
    );
