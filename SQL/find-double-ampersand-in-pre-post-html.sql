-- =====================================================================================================
-- Author:	Luke Taylor
-- Create Date:	Jul 24, 2025
-- Description: Finds {% if %} && {% endif %} in Pre/PostHtml on blocks
--
-- Change History:
--   
-- =====================================================================================================

SELECT
    p.[Id]
    , p.[InternalName]
    , b.[Id] AS [BlockId]
    , b.[Name] AS [Block]
    , b.[PreHtml]
    , b.[PostHtml]
FROM  
    [Block] b 
    INNER JOIN [Page] p ON p.[Id] = b.[PageId]
WHERE
    -- find {% if or {%- if
    
    (CHARINDEX('{% if', [PreHtml]) > 0 OR CHARINDEX('{%- if', [PreHtml]) > 0)
    AND CHARINDEX('&&', [PreHtml]) > 0
    AND (
        -- check for && between opening tag and closing tag, including -%}
        (
            CHARINDEX('{% if', [PreHtml]) > 0
            AND CHARINDEX('&&', [PreHtml]) > CHARINDEX('{% if', [PreHtml])
            AND CHARINDEX('&&', [PreHtml]) < 
                ISNULL(NULLIF(CHARINDEX('%}', [PreHtml], CHARINDEX('{% if', [PreHtml])), 0),
                       CHARINDEX('-%}', [PreHtml], CHARINDEX('{% if', [PreHtml])))
        )
        OR
        (
            CHARINDEX('{%- if', [PreHtml]) > 0
            AND CHARINDEX('&&', [PreHtml]) > CHARINDEX('{%- if', [PreHtml])
            AND CHARINDEX('&&', [PreHtml]) < 
                ISNULL(NULLIF(CHARINDEX('%}', [PreHtml], CHARINDEX('{%- if', [PreHtml])), 0),
                       CHARINDEX('-%}', [PreHtml], CHARINDEX('{%- if', [PreHtml])))
        )
    )
    OR 
        (
    (CHARINDEX('{% if', [PostHtml]) > 0 OR CHARINDEX('{%- if', [PostHtml]) > 0)
    AND CHARINDEX('&&', [PostHtml]) > 0
    AND (
        -- check for && between opening tag and closing tag, including -%}
        (
            CHARINDEX('{% if', [PostHtml]) > 0
            AND CHARINDEX('&&', [PostHtml]) > CHARINDEX('{% if', [PostHtml])
            AND CHARINDEX('&&', [PostHtml]) < 
                ISNULL(NULLIF(CHARINDEX('%}', [PostHtml], CHARINDEX('{% if', [PostHtml])), 0),
                       CHARINDEX('-%}', [PostHtml], CHARINDEX('{% if', [PostHtml])))
        )
        OR
        (
            CHARINDEX('{%- if', [PostHtml]) > 0
            AND CHARINDEX('&&', [PostHtml]) > CHARINDEX('{%- if', [PostHtml])
            AND CHARINDEX('&&', [PostHtml]) < 
                ISNULL(NULLIF(CHARINDEX('%}', [PostHtml], CHARINDEX('{%- if', [PostHtml])), 0),
                       CHARINDEX('-%}', [PostHtml], CHARINDEX('{%- if', [PostHtml])))
        )
    )
        )
    ;
