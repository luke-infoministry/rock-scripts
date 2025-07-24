-- =====================================================================================================
-- Author:	Luke Taylor
-- Create Date:	Jul 24, 2025
-- Description: Show entity attributes that have a && character in an {% if %}. If it's a workflow action type,
--              show that too
--
-- Change History:
--   
-- =====================================================================================================

SELECT
    et.[FriendlyName] AS [EntityType]
    , a.[Name] AS [Attribute]
    , a.[EntityTypeQualifierColumn]
    , a.[EntityTypeQualifierValue]
    , wat.[Name] AS [WorkflowActionType]
    , av.[EntityId]
    , av.[Value]
FROM
    [AttributeValue] av
    INNER JOIN [Attribute] a ON a.[Id] = av.[AttributeId]
    INNER JOIN [EntityType] et ON et.[Id] = a.[EntityTypeId]
    LEFT OUTER JOIN [WorkflowActionType] wat ON wat.[Id] = av.[EntityId]
WHERE
    -- find {% if or {%- if
    (CHARINDEX('{% if', [Value]) > 0 OR CHARINDEX('{%- if', [Value]) > 0)
    AND CHARINDEX('&&', [Value]) > 0
    AND (
        -- check for && between opening tag and closing tag, including -%}
        (
            CHARINDEX('{% if', [Value]) > 0
            AND CHARINDEX('&&', [Value]) > CHARINDEX('{% if', [Value])
            AND CHARINDEX('&&', [Value]) < 
                ISNULL(NULLIF(CHARINDEX('%}', [Value], CHARINDEX('{% if', [Value])), 0),
                       CHARINDEX('-%}', [Value], CHARINDEX('{% if', [Value])))
        )
        OR
        (
            CHARINDEX('{%- if', [Value]) > 0
            AND CHARINDEX('&&', [Value]) > CHARINDEX('{%- if', [Value])
            AND CHARINDEX('&&', [Value]) < 
                ISNULL(NULLIF(CHARINDEX('%}', [Value], CHARINDEX('{%- if', [Value])), 0),
                       CHARINDEX('-%}', [Value], CHARINDEX('{%- if', [Value])))
        )
    );
