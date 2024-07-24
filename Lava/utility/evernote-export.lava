Lava "now" value


	{{ 'Now' | Date:'M/d/yyyy' }}


Beginning of year
```
{% assign yearBeginning = 'Now' | Date:'yyyy' | Prepend:'01/01/' %}
{{ yearBeginning | Date:'MM/dd/yyyy' }}
```

Group Lava for check-in labels
```
{% for group in GroupType.Groups %}{% if forloop.index > 1 %}; {% endif %}{{ group.Name }}{% endfor %}
```

Impersonation Parameter

Basically `rckipid=ATOTALLYRANDOMCODE` needs to be in the querystring.  If you make a link to `Yoururl?{{ Person.ImpersonationParameter }}` it'll sign them in.

[11:20]
And if someone else had been signed in on that comptuer/browser before, they'll be logged out when the link is visited.


Token + shortlink
```
{% assign url = '{{ 'Global' | Attribute:'PublicApplicationRoot' }}page/[PAGE]?rckipid=' %}
{% assign token = Person | PersonTokenCreate %}
{% assign url = url | Append: token %}
[MESSAGE] {{ url | CreateShortLink }}
```

Additional Details
There are several overrides you can pass:
{{ 'url' | CreateShortLink:token,siteId,overwrite,randomLength }}

Definitions

- token (string): If you'd like to provide the token to use in the short code you can provide it here. Leave this blank ('') to use a random code.
- siteId (int): The id of the site to use for the shorting. By default the first site found with the 'Enabled for Shortening' set to true will be used.
- overwrite (bool): This determines what to do if the token you provided already exists. By default it will not overwrite an existing shortcode. Random shortcodes are garanteed to be unique. If you provided a token, it exists and overwrite is set to false, a new random token will be returned.
- randomLength (int): If using a random code, this determines how long it should be.
Example:
"ConnectionOpportunity": {
"Url": "http://www.rocksolidchurchdemo.com/greeters"
}
Your personalized link is:
{{ ConnectionOpportunity | Attribute:'Url' | CreateShortLink }}
Your personalized link is:
http://www.rocksolidchurchdemo.com/HSGFTSF
Note:
This filter attemtps to return a valid shortlink at all cost. This means that if the configuration passed to it is invalid it will try to correct it with reasonable defaults. For instance if you pass in an invalid siteId, the first active site will be used. If you pass in an empty URL, or if no shortened site is enabled in Rock you will get an empty string.

Group Spots Remaining

```
{% for group in sortedgroups %}
        {% assign gmCount = group.Members | Size %}
        {% assign Capacity = group.GroupCapacity  %}
        {% assign Spots = Capacity | Prepend:'0' | Minus:gmCount %}
    {% endfor %}
```

    Spots Remaining: {{ Spots }}


Assign grade from single select

```
{% assign providedGrade = Workflow | Attribute:'Grade' %}
{% assign gradYear = 'Now' | Date:'yyyy' %}
{% assign AddOne = 0 %}
{% assign TransitionDate = 'Global' | Attribute:'GradeTransitionDate' | Date:'yyyy-MM-dd' %}
{% if 'Now' > TransitionDate %}{% assign AddOne = 1 %}{% endif %}
{{ 12 | Minus:providedGrade | Plus:gradYear | Plus:AddOne }}
```

Assign Grade from Defined Value
```
{% assign providedGrade = Workflow | Attribute:'Grade','Value' %}
{% assign gradYear = 'Now' | Date:'yyyy' %}
{% assign AddOne = 0 %}
{% assign TransitionDate = 'Global' | Attribute:'GradeTransitionDate' | Date:'yyyy-MM-dd' %}
{% if 'Now' > TransitionDate %}{% assign AddOne = 1 %}{% endif %}
{{ gradYear | Plus:providedGrade | Plus:AddOne }}
```



kids ages

{% assign ageindays = Person.BirthDate | Date:'MM/dd/yyyy' | DateDiff:'Now', 'd' %}
{% if ageindays < 30 %}
{{ Person.BirthDate | Date:'MM/dd/yyyy' | DateDiff:'Now', 'd' }}d
{% elseif ageindays < 730 %}
{{ Person.BirthDate | Date:'MM/dd/yyyy' | DateDiff:'Now', 'M' }}m
{% else %}
{{ Person.Age }}y
{% endif %}

---

account total

Kevin Rutledge [5:42 PM]
@eddyb This sql will get the sum for the account. Just change the ft.AccountId = 1 to the number of the account.

```SELECT
    Sum(ft.Amount)
FROM
    [FinancialTransactionDetail] ft
Where
    ft.AccountId = 1```

[5:45]
@eddyb this is the output lava on the DD block

{% for row in rows %}
<h3>Total Given for Hurricane Harvey Relief: {{ row.TotalGiven | FormatAsCurrency  }}</h3>
{% endfor %} (edited)

---

full width image

div class="row hero-image"
.hero-image {
    background-image: url('path_to_your_image');
    background-size: cover;
}

person image url



	<img src="{{ CurrentPerson.PhotoUrl }}">



---

return spouse based on parents definition



```
{% assign parents = PersonId | PersonById | Parents %}
{% for parent in parents %}
    {{ parent.Email }}
{% endfor %}
```

This correctly returns the spouse email address when entered in the Lava column. Demo: http://rock.rocksolidchurchdemo.com/page/149?ReportId=1003

If you want both emails in a single column, you could do something like this:
```
{{ PersonId | PersonById | Property:'Email' }};
{% assign parents = PersonId | PersonById | Parents %}
{% for parent in parents %}
    {{ parent.Email }}
{% endfor %}
```


```
{{ PersonId | PersonById | Property:'FullName' }} &lt;{{ PersonId | PersonById | Property:'Email' }}&gt;;
{% assign parents = PersonId | PersonById | Parents %}
{% for parent in parents %}
    {{ parent.FullName }} &lt;{{ parent.Email }}&gt;;
{% endfor %}
```

something cool looking with SQL 


Chris Rea [10:58 AM] 
@eholeman This is definitely doable!  You can write your SQL statement to return the groups `Name` as the column `Text` and the Group's `Guid` as the column `Value` then in a Set Attribute Value Action, you can set the value of a Group Attribute to the `RawValue` of your single select!


[11:00] 
@eholeman
```
Quick Example:
Group Type is `42`
Group Attribute in Workflow is called `PlacementGroup`
Single Select Attribute is called `GroupPicker`
Single Select options set to something like :
```Select g.[Guid] as 'Value', g.[Name] as 'Text'
From [Group] g
Where g.GroupTypeId = 42```
Set Attribute Value sets `PlacementGroup` to the value of `{{ Workflow | Attribute:'GroupPicker','RawValue' }}`
```


Pop the trunk:
Michael Garrison [2:56 PM]
@blendakc start by running
SELECT TOP 10 * FROM [Auth] ORDER BY [Id] DESC

in `Admin Tools` -> `Power Tools` -> `SQL Command`


[2:58]
If it was a recent security change, you should hopefully see it in there. Get the number of the ID row that corresponds to your "All Users" deny permission


Michael Garrison [3:05 PM]
Then you can run
UPDATE [Auth] SET [AllowOrDeny] = 'A' WHERE [Id] = x

, replacing `x` with the ID of the row you identified above


[3:05]
that will change "deny all" to "allow all", so you can get it and fix it normally

```
SELECT dbschemas.[name] as 'Schema',
dbtables.[name] as 'Table',
dbindexes.[name] as 'Index',
indexstats.alloc_unit_type_desc,
indexstats.avg_fragmentation_in_percent,
indexstats.page_count
FROM sys.dm_db_index_physical_stats (DB_ID(), NULL, NULL, NULL, NULL) AS indexstats
INNER JOIN sys.tables dbtables on dbtables.[object_id] = indexstats.[object_id]
INNER JOIN sys.schemas dbschemas on dbtables.[schema_id] = dbschemas.[schema_id]
INNER JOIN sys.indexes AS dbindexes ON dbindexes.[object_id] = indexstats.[object_id]
AND indexstats.index_id = dbindexes.index_id
WHERE indexstats.database_id = DB_ID() AND indexstats.page_count > 15
ORDER BY indexstats.avg_fragmentation_in_percent desc
(show db fragmentation)
```

http://rock.highlandschurch.org/XXX URL HERE XXX?rckipid={{ Person | PersonTokenCreate }}

Chris McGrath [12:19 PM]
@Wesley Jones (and anyone else who could use it) Here is some SQL that will list every unique GivingID in your Person table and give you a well-formatted Name field that contains all the names of the people who match it. It will handle formatting names whether or not everyone in the group has the same last name. (edited)
Untitled
```
select distinct P.GivingID, P.GivingGroupId, P.ID, P.FirstName, LastName = P.LastName + case when S.Value is not null then ' ' + S.Value else '' end, FM.GroupRoleId
    , Gender = case when Gender = 0 then 999 else Gender end -- Sort them as Male, Female, Unknown
    , BirthDate = ISNULL(BirthDate, GETDATE())
    , Deceased = CASE WHEN P.RecordStatusReasonValueId = 167 then 1 else 0 end
    , P.RecordTypeValueId
into #Donors
from Person P
left join DefinedValue S on P.SuffixValueId = S.Id
join GroupMember FM on FM.PersonID = P.ID
join [Group] F on FM.GroupID = F.ID and F.GroupTypeId = 10;
-- Remove the names of any deceased people in groups where at least one person is not deceased
delete D
from #Donors D
where exists (select * from #Donors D0 where Deceased = 0 and D0.GivingID = D.GivingID)
and exists (select * from #Donors D1 where Deceased = 1 and D1.GivingID = D.GivingID)
and Deceased = 1
-- Or, if you don't want to include deceased people at all
--delete D from #Donors D where Deceased = 1
     
-- Find out how many last names are assigned to this GivingID
select GivingID, LastNames = count(distinct ltrim(rtrim(LastName)))
into #LastNameCounts
from #Donors D
group by GivingId
-- Format the name field for each GivingID, separated by commas
select distinct G.GivingID
    , Name = case when (select LastNames from #LastNameCounts where GivingID = G.GivingID) = 1 -- All share a last name
                then ltrim(rtrim(SUBSTRING((select ', ' + ltrim(rtrim(FirstName)) from #Donors where GivingID = G.GivingID order by GroupRoleId, Gender, BirthDate, ID for xml path ('')), 3, 99999) -- First Names
                        + ' '
                        + (select top 1 ltrim(rtrim(LastName)) from #Donors where GivingID = G.GivingID))) -- Last Name
                else ltrim(rtrim(substring((select ', ' + ltrim(rtrim(FirstName)) + ' ' + ltrim(rtrim(LastName)) from #Donors where GivingID = G.GivingID order by GroupRoleId, Gender, BirthDate, ID for xml path ('')), 3, 99999)))
                end
    , RecordTypeValueId
into #Names
from #Donors G;
-- Update Person names (not Businesses) to use an & instead of the last comma
update #Names
set Name = case when charindex(', ', Name) > 0
        then reverse(substring(reverse(Name), 0, charindex(reverse(', '), reverse(Name))) + reverse(' & ') + substring(reverse(Name), charindex(reverse(', '), reverse(Name)) + datalength(', '), datalength(Name)))
        else Name
        end
where RecordTypeValueId = 1
select GivingId, Name from #Names
Collapse
```
You can paste this into the SQL Power Tool on the Rock demo site if you want to see some sample data
If you have someone writing an SQL query they can use this in there. Otherwise I think you can create a dataview and join it together with your current report. I'm not super familiar with building reports that way in Rock so maybe someone else can advise you on the best way to make that work
---
Looking at this... don't have an answer yet... But it looks like what is being returned is actually a PersonAlias Guid. For example, I have a workflow that has an Attribute of type Person named 'Requester'. I created a Dataview for that Workflow Type and then a Report. In the Report, I listed the 'Requester' workflow attribute as well as a second field that was a Lava field simply with {{ Requester }} in it. The Requester field correctly shows the Person's name. The Lava field shows a Guid. When I look at Guid up, it is found in the PersonAlias table. So, you could use Entity commands to get the PersonAlias for that Guid, then get the associated Person, and finally then the Attribute you want. Unfortunately, there is no 'PersonByAliasGuid' Lava filter, although there is a 'PersonByAliasId' filter.
```
Something like this returns a value in the Attribute for me:
{%- personalias where:'Guid == "{{- Requester -}}"' -%}
{%- assign p = personalias.Person -%}
{%- endpersonalias -%}
{{- p.FullName -}} - {{- p | Attribute:'FirstVisit' -}}

You don't have to assign the Person to a variable, as this also works:
{%- personalias where:'Guid == "{{- Requester -}}"' -%}
{{- personalias.Person.FullName -}} - {{- personalias.Person | Attribute:'FirstVisit' -}}
{%- endpersonalias -%}
```


Don't display grades:
```
What grade will you be in for the 2018/2019 school year?
<style type="text/css">
    .modified-grade option[value="0"] {display:none;}
    .modified-grade option[value="1"] {display:none;}
    .modified-grade option[value="2"] {display:none;}
    .modified-grade option[value="3"] {display:none;}
    .modified-grade option[value="4"] {display:none;}
    .modified-grade option[value="5"] {display:none;}
    .modified-grade option[value="13"] {display:none;}
    .modified-grade option[value="14"] {display:none;}
    .modified-grade option[value="15"] {display:none;}
</style>
<div class="modified-grade">

</div>
```

Report Lava columns can access non-lava columns values by 
```
TheColumnsNameNoSpacesNoSpecialCharacters
```

Disable custom errors
```
<configuration>
    <system.web>
        <customErrors mode="Off"/>
    </system.web>
```

Workflow grab address:
```
{% assign p = Workflow | Attribute:'Person','Object' %}
{% assign groupMembers = p | Groups: "10",'All' %}
{% for groupMember in groupMembers %}
{% assign fid = groupMember.GroupId %}
{% endfor %}
{% grouplocation where:'GroupId == {{fid}}' %}
{% for group in grouplocationItems %}
{% if forloop.last == True %}
{{group.Location.Guid}}
{% endif %}
{% endfor %}
{% endgrouplocation %}

or

(needs RockEntity)
{% if CurrentPerson != null %} 
    {% assign groupMember = CurrentPerson | Groups:'10','All' | First %} 
    {% assign familyId = groupMember.GroupId %} 
        {% grouplocation where:'GroupId == {{ familyId }} && GroupLocationTypeValueId == 19' %}                                     
        {% assign firstHomeLocation = grouplocationItems | First %}
            {{ firstHomeLocation.Location.Guid }} 
        {% endgrouplocation %}
{% endif %}


{% assign p = Workflow | Attribute:'Person','Object' %}
        {% grouplocation where:'GroupId == {{ p.PrimaryFamilyId }} && GroupLocationTypeValueId == 19' %}                                     
        {% assign firstHomeLocation = grouplocationItems | First %}
            {{ firstHomeLocation.Location.Guid }} 
        {% endgrouplocation %}
```

DIY ticketing
```
Took a little doing, but this is the first year we send out digital tickets for our Breakfast with Santa event(we have 203 people coming).  We usually mailed out tickets or did will call.  This year, we sent a link to a page where they could print/screenshot their tickets.  The tickets have a barcode on them that is essentially their Registration.Id(for this event that works and I already sent the email when I realized their was a better way to make this work across multiple events).

I have a page with an event selection dropdown that shows the active event registrations.  a text entry box and the submit button hidden.  the barcode scanner will scan the code and submit, which triggers a workflow.

The workflow first checks to see if the registration instance in the URL parameter matches the default value in the workflow(might change this to only receive the one submitted in thew workflow to make it useful across events).  Then I get the person attached to the registration(will change this to registration registrant and encode that in the barcode).  I do a test using the registraitonid and instance passed to the workflow to grab that person, so if there is no person, it was not a valid ticket and the default invalid response redirect is  triggered.

If the person is present, I check to see if the person is in a default barcode scaned group.  If they are, it means the barcode was scanned, and the default error redirect is triggered.

If the person is not in the group, they are added to the group, and a success redirect is sent.

Both the success and failure redirect go to the original page with the barcode.  But using the following parameters:

?InstanceId={{Workflow | Attribute:'InstanceId'}}&RegistrationId={{Workflow | Attribute:'barcode'}} - Success

?InstanceId={{Workflow | Attribute:'InstanceId'}}&RegistrationId={{Workflow | Attribute:'barcode'}}&scanfailed=true  - Fail

There is a block on the original page that checks for these parameters.  The dropdown gets changed to the registration instance in the url so they can keep scanning for the same event and the text box autofocuss.

If scanfailed=true, the background is changed red and an error buzzer tone is shown.  Either showing that the ticket was invalid(not for this event) or the ticket was already scanned(already in the barcode scanned group).

otherwise, it shows a success( background is green, success tone is played and event registration info is shown with name, fees, etc).

The user can keep scanning barcodes at this point, but javascript changes the background back to white and clears the ticket info after about 3 seconds to prevent confusion.

I am able to scan the barcodes with a .99 app on my iphone(cant force sound to play).  I am waiting to receive the scanner we purchased to test that today. (edited)
```

He;lp someone emailed the world their person token
```
SELECT pt.[Id] AS [PersonTokenId]
      ,[PersonAliasId]
      ,[Token]
      ,[ExpireDateTime]
      ,[TimesUsed]
      ,[UsageLimit]
      ,[LastUsedDateTime]
      ,[PageId]
  FROM [PersonToken] pt
  INNER JOIN [PersonAlias] pa ON pa.[Id] = pt.[PersonAliasId]
  WHERE pa.[PersonId] = 2 -- Change this PersonID
  ORDER BY pt.[Id] DESC

and change the PersonId in the WHERE clause to the staff person's. You can find this in the URL of that person's profile page.

Once you find the offending token id (the first column of the result). The use this SQL statement:

DELETE FROM [PersonToken] WHERE [Id] = 999999
```

Progress bar
```
{% assign title = 'Progress Bar' %}
{% assign startdate = '1/1/2018' %}
{% assign enddate = '12/31/2018' %}
{% assign now = 'Now' | Date:'M/d/yyyy' %}
{% if title != '' and startdate != '' and enddate != '' %}
    {% assign totalDays = startdate | DateDiff:enddate,'d' %}
    {% assign daysSurpassed = startdate | DateDiff:now,'d' %}
    {% assign daysLeft = now | DateDiff:enddate,'d' %}
    {% assign progressPercent = daysSurpassed | DividedBy:totalDays | Times:100 %}
    <b>{{ title }}</b>
    <span class="pull-left">{{ startdate }}</span>
    <span class="pull-right">{{ enddate }}</span>
    <div class="progress">
        <div class="progress-bar {% if progressPercent < 100 %}progress-bar-striped active{% endif %}" role="progressbar" aria-valuenow="{% if progressPercent > 100 %}100{% else %}{{ progressPercent }}{% endif %}" aria-valuemin="0" aria-valuemax="100" style="width: {% if progressPercent > 100 %}100{% else %}{{ progressPercent }}{% endif %}%;">
            {% if progressPercent > 100 %}Timeline Complete{% else %}{{ daysLeft }} Days Remaining{% endif %}
        </div>
    </div>
{% endif %}
```

```
with locationinfo (groupId, IsMailingLocation, [Count]) As ( Select g.Id ,gl.IsMailingLocation ,Count(*) Over (Partition By g.Id) as locationcount From [Group] g Join GroupLocation gl on gl.GroupId = g.Id Join Location l on l.Id = gl.LocationId Where GroupTypeId = 10 ) Select * from locationinfo where [Count] = 1 and IsMailingLocation = 0

this sql should get you the families that have only 1 address and no mailing address
```

Giving Units report
```
with cte_count as
(SELECT
        [p].[GivingId], count([p].[GivingId]) '#TimesGiven'
        FROM [FinancialTransaction] [ft]
        INNER JOIN [FinancialTransactionDetail] [ftd]
            ON [ftd].[TransactionId] = [ft].[Id]
        INNER JOIN [FinancialAccount] [fa]
            ON [fa].[Id] = [ftd].[AccountId]
        INNER JOIN [PersonAlias] [pa]
            ON [pa].[Id] = [ft].[AuthorizedPersonAliasId]
        INNER JOIN [Person] [p]
            ON [p].[Id] = [pa].[PersonId]
        LEFT OUTER JOIN [FinancialPaymentDetail] [fpd]
            ON [fpd].[Id] = [ft].[FinancialPaymentDetailId]
        WHERE [ftd].[AccountId] IN ( 5, 8, 12, 16, 31,32, 33, 34,39 )
        and ft.TransactionDateTime > DateAdd(yy, -1, GetDate())
        group by [p].[GivingId] )
select count(*) from cte_count
```

 Rock Star Hall of Fame 9:42 PM
I found this on the Goog and put it on the Workflow Entry page. It does prevent going back(the back button is still clickable), but has a visual glitch where you see the prior page briefly, then the current one shows again and you haven't moved. Better than nothing 

 
```
```
< script type="text/javascript">
    function preventBack()
{
window
.history.forward();}
setTimeout(
"preventBack()"
,
0
);
window
.onunload=
function
()
{
null
};
</
script
>
```
OOoh... this works even better. No glitch, no back when on the workflow page.
```
<
script
>
history.pushState(
null
,
null
, location.href);
window
.onpopstate =
function
()
{
history.go(
1
);
};
</
script
>
```
 Rock Star 6:30 AM  
Jim Michael I have an wf entry block on a page with this pageroute 
`
entry/{WorkflowTypeGuid}/{WorkflowTypeId},entry,entry/{WorkflowTypeGuid}
`

I have this in the Pre-HTML
```
```
{% assign guid = PageParameter['WorkflowTypeGuid']%}
{% assign id = PageParameter['WorkflowTypeId']%}
{% assign passed = 'invalidGuid' %}
<!-- check to see if the guid is present and grab the workflowtypeid using the guid -->
{% if guid and guid != '' %}
{% workflowtype where:'Guid == "{{guid}}"'%}
{% for item in workflowtypeItems%}
{% assign count = forloop.length %}
{% assign idtest = workflowtype.Id %}
{% endfor %}
{% endworkflowtype %}
{%- capture url -%}
/entry/
{{guid}}
/
{{idtest}}
{% endcapture %}
{% else %}
{% assign passed = "InvalidGuid'%}
{% endif %}
{% if count == 1%}
{% assign passed = 'validguid' %}
{% endif %}
{% if passed and passed == 'validguid' %}
{% if id and id != '' and id == idtest %}
<!-- This is really the do nothing state because everything is fine -->
{% assign passed = "True" %}
{% else %}
{{url | PageRedirect }}
{% endif %}
{% else %}
<h2>This is not a valid entry point! Please see ....</h2>
{% if PageParameter['show'] != 'True' %}
<script>
$(function()
{$('#passed').remove();});
</script>
{% endif %}
{% endif %}

< div id="passed" style="{% if passed != 'True' and PageParameter['show'] != 'True' %} display:none;{% endif %}">

and put
`
</div>
`
in the post HTML.
```



First it checks to see if the GUID is valid. If the GUID is not valid, you can display a message or redirect somewhere. Right now it says "Someone tampered with the URL.

Second, if the GUID is valid, we check to see if the id is in the url and matches the id of the supplied GUId. if everything matches, we change the passed variable value to true which shows the workflow entry. If the id in url and in guid do not match, then it just redirects to the correct entry id. People can change the id of the workflow type and it will always go to the entry of the supplied guid.

Now this does use display none to hide the entry which means it is there just not visible.

Get Person Primary Alias Guid
```
{{ Person | Property:'PrimaryAlias.Guid' }}
```
Financial Transaction Person, Triggered WF
```
{{ Entity.AuthorizedPersonAliasId | PersonByAliasId | Property:'PrimaryAlias.Guid' }}
```


Figure out what an entity is passing:
In situations like that, I create a text attribute called EntityJSON or whatever, then set that attribute via (Set Attribute From Entity action) 
`
{{ Entity | ToJSON }}
`
 Then I run the WF to create an instance, go to Lava tester and target my WF instance and do 
`
<pre>{{ Workflow | Attribute:'EntityJSON' }}</pre>
`
 which give you a nice formatted output of everything that got passed to the WF.

Person from group member workflow:  {{ Entity.PersonId | PersonById | Property:'PrimaryAlias' | Property:'Guid' }}

Giving Households by month:
```
```
SELECT Month, COUNT(Family) [Family Giving Units]
FROM ( SELECT Month, Family FROM ( SELECT G.Id [Family], FORMAT(t.TransactionDateTime, 'yyyy-MM') [Month] FROM FinancialTransaction t INNER JOIN FinancialTransactionDetail td ON t.Id = td.TransactionId INNER JOIN PersonAlias PA ON t.AuthorizedPersonAliasId = PA.Id INNER JOIN Person ON PA.PersonId = Person.Id INNER JOIN [GroupMember] GM ON GM.PersonId = PA.PersonId INNER JOIN [Group] G ON GM.GroupId = G.Id AND G.GroupTypeId = 10 WHERE t.TransactionTypeValueId != 54 ) as FamilyMonths GROUP BY Month, Family ) FamilyMonthCounts GROUP BY Month ORDER By Month Desc
```
by year
```
SELECT Year, COUNT(Family) [Family Giving Units] FROM ( SELECT Year, Family FROM ( SELECT G.Id [Family], FORMAT(t.TransactionDateTime, 'yyyy') [Year] FROM FinancialTransaction t INNER JOIN FinancialTransactionDetail td ON t.Id = td.TransactionId INNER JOIN PersonAlias PA ON t.AuthorizedPersonAliasId = PA.Id INNER JOIN Person ON PA.PersonId = Person.Id INNER JOIN [GroupMember] GM ON GM.PersonId = PA.PersonId INNER JOIN [Group] G ON GM.GroupId = G.Id AND G.GroupTypeId = 10 WHERE t.TransactionTypeValueId != 54 ) as FamilyYears GROUP BY Year, Family ) FamilyYearCounts GROUP BY Year ORDER By Year Desc
```

shove family into workflow single select
```
{% assign family = Person | Groups:'10' %}{% for familymember in family %}{{familymember.Id}}^{{familymember.FullName}}{% endfor %}

just add a `{% assign person = 'Global' | PageParameter:'PersonId'%}`


{% assign gid = 'Global' | PageParameter:'GroupId' | GroupById %} {% assign gms = gid.Members %} {% for gm in gms %} {% assign grid = gm.GroupRoleId %} {% if grid == '181' or grid == '182' or grid == '188' %} {{gm.PersonId}}^{{gm.Person.FullName}}, {% if forloop.last == 'True' %} {{gm.PersonId}}^{{gm.Person.FullName}} {% endif %} {% endif %} {% endfor %}

```

Workflow Person Attribute type Primary Alias Guid
```
{{ Workflow | Attribute:'Person','PrimaryAlias.Guid'}}`
```

Person has a primary family Id
workflow:

```
{{ Workflow | Attribute:'Person', 'Object'| Property:'PrimaryFamilyId' }}`

```

SQL for metric around baptism (174 is attribute id)
```
DECLARE @DateAttribute Int = 174
DECLARE @StartDate DateTime = DATEADD(month, DATEDIFF(month, 0, GETDATE())-1, 0) --First day of last month
DECLARE @EndDate DateTime = DATEADD(month, 1, @StartDate)

SELECT
    COUNT(DISTINCT P.[Id]) AS 'Total'
    ,@EndDate AS 'MetricValueDateTime'
    ,G.[CampusId] AS 'CampusId'
FROM
    [AttributeValue] AV
    INNER JOIN [Person] P ON P.[Id] = AV.[EntityId]
    INNER JOIN [Group] G ON G.[Id] = P.[PrimaryFamilyId]
WHERE
    AV.[AttributeId] = @DateAttribute
    AND AV.ValueAsDateTime >= @StartDate
    AND AV.ValueAsDateTime < @EndDate
GROUP BY
    G.[CampusId]
```

Lava for people who can check in kids
```
<pre>
The following individuals are allowed to check in {{ Person.FullName }}:
{%- assign groupMembers = Person | Groups:'10' -%}
{%- for groupMember in groupMembers -%}
    {%- for member in groupMember.Group.Members -%}
        {%- if member.GroupRole.Name == "Adult" %}- {{ member.Person.FullName }}
        {%- endif -%}
    {%- endfor -%}
{%- endfor -%}
{%- assign groupMembers = Person | Groups:'11' -%}
    {%- for groupMember in groupMembers -%}
        {%- for member in groupMember.Group.Members -%}
            {%- if member.GroupRole.Name == "Allow check in by" -%} {{ member.Person.FullName }}
        {%- endif -%}
    {%- endfor -%}
{%- endfor -%}
</pre>

```

Workflow Person's Family Guid
```
{% assign f = Workflow | Attribute:'Person', 'Object' | Property:'PrimaryFamilyId' %}
{% assign g = f | GroupById %}
{{ g.Guid }}
```

Workflow set Address (Lava Run Action)
```

{% sql %}
    SELECT TOP 1 L.[Guid]
    FROM [PersonAlias] PA
    INNER JOIN [GroupMember] GM ON GM.[PersonId] = PA.[PersonId]
    INNER JOIN [Group] G ON G.[Id] = GM.[GroupId] AND G.[GroupTypeId] = 10
    INNER JOIN [GroupLocation] GL ON GL.[GroupId] = G.[Id] AND GL.[GroupLocationTypeValueId] = 19
    INNER JOIN [Location] L ON L.[Id] = GL.[LocationId]
    WHERE PA.[Guid] = '{{ Workflow | Attribute:'Attendee','RawValue' }}'
    ORDER BY ISNULL(GM.[GroupOrder], 99999)
{% endsql %}
{% for item in results %}
    {{ item.Guid }}
{% endfor %}
```

Replace last comma in a series
```
{% capture out %}
    {% for group in groupItems %}
        {{ group.Name }},
    {% endfor %}
{% endcapture %}
{{ out | ReplaceLast:',','' }}
```
or
```
{% for group in groupItems %}
    {{ group.Name }}{% unless forloop.last %}, {% endunless %}
{% endfor %}
```

Single Select group member lava

```


{% assign gid = 'Global' | PageParameter:'GroupId' | GroupById %}
{% if gid != '' or gid != null %}
{% assign gms = gid.Members %}
{% capture out %}
{% for gm in gms %}
{% assign grid = gm.GroupRoleId %}
{% if grid == '181' or grid == '182' or grid == '188' %}
{{gm.PersonId}}^{{gm.Person.FullName | Append:','}}
{% endif %}
{% endfor %}
{% endcapture %}
{{ out | ReplaceLast:',','' }}
{% else %}
{% endif %}

```


{% assign gid = Workflow | Attribute:'SetFamily','GroupId' %}
{% assign gms = gid.Members %}
{% for gm in gms %}
{{ gm.Person.FullName }}
{% endfor %}

Report lava person action linkelse 
```
{% assign p = Id | PersonById %}


<a href="https://rock.church.org/WorkflowEntry/33?Person={{ p.PrimaryAlias.Guid }}" class="btn btn-sm btn-default"><i class="fa fa-envelope-square"></i> 7 Day</a>
```

List of people with upcoming birthday
```
{% person where:'DaysToBirthday < "31"' %}
```
List of people in dataview with upcoming birthday
```
<h2> Staff Birthday's This Month</h2> {% person dataview:'13' sort:'BirthMonth,BirthDay' %} {% for person in personItems %} {% if person.DaysUntilBirthday < 31 %} {{ person.FullName }} | {{ person.BirthDate | Date:'MMM' }} {{ person.BirthDay | AsString | NumberToOrdinal }}<br /> {% endif %} {% endfor %} {% endperson %}
```

why {(- is important for if statements: 
```
(Mark Wampler)
This is also relevant when using `{% capture %}` as it will capture your line breaks and render them causing an array to look like this `1, 2, 3, 4, 5` instead of `1,2,3,4,5` which causes issues if you are using `If` statements to compare if a value is there. You want to compare `2` not ` 2`
☝ 1

```

davidturner 10:54 AM
Brady Funkhouser we added the following script to the Pre-HTML setting on the check-in Search block's settings to have the search automatically search once 7 digits are entered...

```
<script>
    var interval = setInterval( checkSearchLen, 400 );
    function checkSearchLen() {
        var inputLen = $('.checkin-phone-entry').val().length;
        if ( inputLen >= 7 ) {
            clearInterval(interval);
            $('.btn-primary')[0].click();
            eval( $('.btn-primary').attr('href') );
        }
    }
</script>
```

SQL Query from Taylor Brooks for transactions
```
SELECT
    datename(month, t.TransactionDateTime),
    c.Name [Campus],
    a.Name [Fund],
    SUM(td.Amount) [Amount]
FROM FinancialTransaction t
INNER JOIN FinancialTransactionDetail td
    ON t.Id = td.TransactionId
INNER JOIN FinancialAccount a
    ON td.AccountId = a.Id
LEFT JOIN Campus c
    ON a.CampusId = c.Id
WHERE
    t.TransactionTypeValueId != 54 AND t.TransactionDateTime > DATEADD(month, -3, getdate())
GROUP BY
    c.Name,
    a.Name,
    datename(month, t.TransactionDateTime),
    MONTH(t.TransactionDateTime)
ORDER BY
    MONTH(t.TransactionDateTime),
    c.Name,
    a.Name
```

Show metric Id on metric detail page
```
<script>
    $(function() {
        var metricId = $('[id$="hfMetricId"]').val();
        $(".panel-title").append(' (Id: ' + metricId + ')');
    });
</script>
```

Assign date range attribute from single date
```
{% assign bd = 'Global' | Attribute:'BaptismDate' %}
{% assign 1bd = bd | DateAdd:-3,'w' %}
{% assign 2bd = bd | DateAdd:-1,'d' %}
{{ 1bd }},{{ 2bd }}
```

Query for people in more than one family
```
SELECT
    gm.[PersonId], CONCAT(p.[NickName],' ', p.[LastName]) AS [Name], Count (*)
FROM
    [GroupMember] gm
    LEFT JOIN [Person] p on p.[Id] = gm.[PersonId]
WHERE   
    gm.[Id]
    IN (SELECT
    gm1.[Id]
    FROM
    [GroupMember] gm1
    INNER JOIN [Group] g ON g.[Id] = gm1.[GroupId] AND g.[GroupTypeId] = 10


    )
    GROUP BY
    gm.[PersonId], p.[NickName], p.[LastName]
HAVING COUNT(gm.[PersonId]) > 1

```
Same, for people in specified Persisted Dataview
```
SELECT
    *
FROM [Person] p
WHERE p.[Id]
        IN (
        SELECT
            gm.[PersonId]
        FROM
            [GroupMember] gm
            LEFT JOIN [Person] p on p.[Id] = gm.[PersonId]
        WHERE   
            gm.[Id]
            IN (SELECT
            gm1.[Id]
            FROM
            [GroupMember] gm1
            INNER JOIN [Group] g ON g.[Id] = gm1.[GroupId] AND g.[GroupTypeId] = 10
       
            )
            GROUP BY
            gm.[PersonId], p.[NickName], p.[LastName]
        HAVING COUNT(gm.[PersonId]) > 1
        )
    AND
    p.[Id] IN(
            SELECT
                p2.[Id]
            FROM
                [Person] p2
            INNER JOIN [DataViewPersistedValue] dvpv ON p2.[Id] = dvpv.[EntityId]
                   
AND dvpv.[DataViewId] = 78 --Update this to the persisted Data View Id
   
    )
```

Assign CurrentPerson
```
danielhazelbaker
Rock Star
Hall of Fame
9:42 AM
Nope, something like `{% assign CurrentPerson = 1 | PersonById %}` (assuming 1 is your admin user's person id or something). Basically, you assign `CurrentPerson` to be a person object of a person that has permissions to view that stuff.
```

List of family members as tokenized links
```
<ul>
{% for Member in Person.PrimaryFamily.Members %} 
{% assign token = Member.Person | PersonTokenCreate %}
{% assign url = url | Append: token %}
<li><a href="{{ 'Global' | Attribute:'PublicApplicationRoot' }}page/1655?rckipid={{ token }}">{{ Member.Person.NickName }}</a></li>
{% endfor %}
</ul>
```

Contribution Statement - Giving total
```
{% capture pageTitle %}{{ 'Global' | Attribute:'OrganizationName' }} | Contribution Statement{%endcapture%}
{{ pageTitle | SetPageTitle }}


<div class="row margin-b-xl">
    <div class="col-md-6">
        <div class="pull-left">
            <img src="{{ 'Global' | Attribute:'PublicApplicationRoot' }}{{ 'Global' | Attribute:'EmailHeaderLogo' }}" width="100px" />
        </div>


        <div class="pull-left margin-l-md margin-t-sm">
            <strong>{{ 'Global' | Attribute:'OrganizationName' }}</strong><br />
            {{ 'Global' | Attribute:'OrganizationAddress' }}<br />
            {{ 'Global' | Attribute:'OrganizationWebsite' }}
        </div>
    </div>
    <div class="col-md-6 text-right">
        <h4>Charitable Contributions for the Year {{ StatementStartDate | Date:'yyyy' }}</h4>
        <p>{{ StatementStartDate | Date:'M/d/yyyy' }} - {{ StatementEndDate | Date:'M/d/yyyy' }}<p>
    </div>
</div>


<h4>
{{ Salutation }} <br />
{{ StreetAddress1 }} <br />
{% if StreetAddress2 and StreetAddress2 != '' %}
    {{ StreetAddress2 }} <br />
{% endif %}
{{ City }}, {{ State }} {{ PostalCode }}
</h4>




<div class="clearfix">
    <div class="pull-right">
        <a href="#" class="btn btn-primary hidden-print" onClick="window.print();"><i class="fa fa-print"></i> Print Statement</a>
    </div>
</div>


<hr style="opacity: .5;" />


<h4 class="margin-t-md margin-b-md">Gift List</h4>




    <table class="table table-bordered table-striped table-condensed">
        <thead>
            <tr>
                <th>Date</th>
                <th>Giving Area</th>
                <th>Check/Trans #</th>
                <th align="right">Amount</th>
            </tr>
        </thead>


        {% for transaction in TransactionDetails %}
            <tr>
                <td>{{ transaction.Transaction.TransactionDateTime | Date:'M/d/yyyy' }}</td>
                <td>{{ transaction.Account.Name }}</td>
                <td>{{ transaction.Transaction.TransactionCode }}</td>
                <td align="right">{{ transaction.Amount | FormatAsCurrency }}</td>
            </tr>
        {% endfor %}


    </table>








<div class="row">
    <div class="col-xs-6 col-xs-offset-6">
        <h4 class="margin-t-md margin-b-md">Fund Summary</h4>
        <div class="row">
            <div class="col-xs-6">
                <strong>Fund Name</strong>
            </div>
            <div class="col-xs-6 text-right">
                <strong>Total Amount</strong>
            </div>
        </div>
        {% assign TotalAllFunds = 0 %}
        {% for accountsummary in AccountSummary %}
            <div class="row">
                <div class="col-xs-6">{{ accountsummary.AccountName }}</div>
                <div class="col-xs-6 text-right">{{ accountsummary.Total | FormatAsCurrency }}</div>
            </div>
            {% assign TotalAllFunds = TotalAllFunds | Plus:accountsummary.Total %}
        {% endfor %}
        <div class="row">
                <div class="col-xs-6"><strong>Giving Total</strong></div>
                <div class="col-xs-6 text-right">{{ TotalAllFunds }}</div>
            </div>
    </div>
</div>


{% assign pledgeCount = Pledges | Size %}


{% if pledgeCount > 0 %}
    <hr style="opacity: .5;" />
    <h4 class="margin-t-md margin-b-md">Pledges <small>(as of {{ StatementEndDate | Date:'M/dd/yyyy' }})</small></h4>


    {% for pledge in Pledges %}
        <div class="row">
            <div class="col-xs-6">
                <strong>{{ pledge.AccountName }}</strong>


                <p>
                    Amt Pledged: {{ pledge.AmountPledged | FormatAsCurrency }} <br />
                    Amt Given: {{ pledge.AmountGiven | FormatAsCurrency }} <br />
                    Amt Remaining: {{ pledge.AmountRemaining | FormatAsCurrency }}
                </p>
            </div>
            <div class="col-xs-6 padding-t-md">
                <div class="hidden-print">
                    Pledge Progress
                    <div class="progress">
                      <div class="progress-bar" role="progressbar" aria-valuenow="{{ pledge.PercentComplete }}" aria-valuemin="0" aria-valuemax="100" style="width: {{ pledge.PercentComplete }}%;" style="max-width:100%;min-width:2em;">
                        {{ pledge.PercentComplete }}%
                      </div>
                    </div>
                </div>
                <div class="visible-print-block">
                    Percent Complete <br />
                    {{ pledge.PercentComplete }}%
                </div>
            </div>
        </div>
    {% endfor %}
{% endif %}


<hr style="opacity: .5;" />
<p class="text-center">
    Thank you for your continued support of the {{ 'Global' | Attribute:'OrganizationName' }}. If you have any questions about your statement,
    email {{ 'Global' | Attribute:'OrganizationEmail' }} or call {{ 'Global' | Attribute:'OrganizationPhone' }}.
</p>


<p class="text-center">
    <em>Unless otherwise noted, the only goods and services provided are intangible religious benefits.</em>
</p>
```

Interactions by date
```
SELECT
    CONCAT( datepart(month,[CreatedDateTime]), '/', datepart(day,[CreatedDateTime]), '/', datepart(year,[CreatedDateTime]) ) as 'Date',
    COUNT(*) AS 'Total Interactions (per day)'
FROM
    [Interaction]
GROUP BY
    datepart(year,[CreatedDateTime]),
    datepart(month,[CreatedDateTime]),
    datepart(day,[CreatedDateTime])
ORDER BY
    datepart(year,[CreatedDateTime]) ASC,
    datepart(month,[CreatedDateTime]) ASC,
    datepart(day,[CreatedDateTime]) ASC
```

Query of usage of phone numbers by last 4
```
SELECT
  Count(LEFT(NumberReversed, 4)), Reverse(Left(NumberReversed, 4))
FROM
    [PhoneNumber] pn
GROUP BY
    Left([NumberReversed], 4)
ORDER BY
    Left([NumberReversed], 4) ASC
```

Required entry dot for hidden label workflow questions
```
<span style="margin-left: 4px;
    font-family: 'FontAwesome';
    font-size: 6px;
    font-weight: 900;
    color: #d4442e;
    vertical-align: super;
    content: "\f111";"><i class="fas fa-circle"></i></span>
```

Assign Groups of a group type from Current Person (As Workflow attribute single select)
```
{% assign p = CurrentPerson %}
{% assign groupMembers = p | Groups:"65",'All' %}
    {% for groupMember in groupMembers %}
        {{ groupMember.Group.Guid }}^{{ groupMember.Group.Name }}
    {% endfor %}
```

Show default connectors per campus at opportunities in a given connection type
```
SELECT
    co.[Name] AS [Opportunity], c.[Name] AS [Campus], CONCAT(p.[FirstName],' ',p.[LastName]) AS [Name]
FROM
    [ConnectionOpportunity] co
    INNER JOIN [ConnectionOpportunityCampus] coc ON coc.[ConnectionOpportunityId] = co.[Id]
    INNER JOIN [Campus] c ON c.[Id] = coc.[CampusId]
    INNER JOIN [PersonAlias] pa ON pa.[Id] = coc.[DefaultConnectorPersonAliasId]
    INNER JOIN [Person] p ON p.[Id] = pa.[PersonId]
WHERE
    co.[ConnectionTypeId] = '7'
```
Redirect to self page (Internal)
```
{{- 'Global' | Attribute:'InternalApplicationRoot' -}}{{ 'Global' | Page:'Path' | RemoveFirst:'/' }}
```
Redirect to self page (External)
```
{{- 'Global' | Attribute:'PublicApplicationRoot' -}}{{ 'Global' | Page:'Path' | RemoveFirst:'/' }}
```
Email wizard from name/from address
```
<tr>
    <td class="js-component-text-wrapper" style="border-color: rgb(0, 0, 0);">
        <p>
            {% raw %}{{ Communication.FromName }}{% endraw %}<br />
            <a href="mailto:{% raw %}{{ Communication.FromEmail }}{% endraw %}" style="color: #2ba6cb; text-decoration: none;">{% raw %}{{ Communication.FromEmail }}{% endraw %}</a>
        </p>
    </td>
</tr>
```

Kick out an impersonated link in Lava tester
```
{% assign url = "https://summitwomensconference.com/access"%}
{% assign url = url | Append:'?' | Append: Person.ImpersonationParameter %}
<a href="{{ url }}">{{ url }}</a>
```

Get all person aliases into an array for Entity Commands
```
{% assign personAliases = person.Aliases | Map:'Id' | Join:'" || PersonAliasId == "' | Prepend:'PersonAliasId =="' | Append:'"' %}
{% step where:'{{ personAliases }} && StepTypeId == "6"' %}

SELECT person preferences
```
DECLARE @EntityTypeId int = ( SELECT TOP 1 [Id] FROM [EntityType] WHERE [Name] = 'Rock.Model.Person.Value' )DECLARE @PersonId INT = {insert id here}SELECT *FROM [Attribute] AINNER JOIN [AttributeValue] V  ON V.[AttributeId] = A.[Id]  AND V.[EntityId] = @PersonIdWHERE A.[EntityTypeId] = @EntityTypeId


Get Campus Guid from Metric Value JSON

{% metricvalue id:'16183' %} {% endmetricvalue %}{% assign partitions = metricvalue.MetricValuePartitionEntityIds | Split:',' %}{% for partition in partitions %}     {% assign par = partition | Split:'|' %}         {% if par[0] == 67 %}             {{ Campuses | Where:'Id',par[1] | Select:'Guid' }}
         {% endif %}{% endfor %}

Person Entry - spouse column Workflow Hack
We use a javascript "hack" to format this into 2 columns on forms that don't need the spouse entry. This goes in the footer of the form.
```
```
<script>
    Sys.Application.add_load(function () {
        // Remove spouse fields
        $('[id$="pnlPersonEntryRow1Column2"]').remove();
        $('[id$="pnlPersonEntryRow2Column2"]').remove();
        
        // Make person fields 2-column
        $('[id$="pnlPersonEntryRow1Column1"]').removeClass('col-md-6');
        $('[id$="pnlPersonEntryRow1Column1"] .form-group').addClass('col-md-6');
        
        // Make address full width
        $('[id$="pnlPersonEntryRow2Column1"]').removeClass('col-md-6').addClass('col-md-12');
    });
</script>

```
```
If you end up going this route, make sure to add it to your list of things to test before updating Rock. It _shouldn't_ cause any issues, but it is always best to be sure.

Trick for SQL-based single-selects
```
SELECT
    *
FROM
    ( VALUES 
        (1,'Friday, December 24th 1:00 p.m.'),
        (3,'Friday, December 24th 3:00 p.m.'),
        (5,'Friday, December 24th 5:00 p.m.')
    ) AS c([Value],[Text])
```


1. make a new variable called registrant
2. go look for the array called Registrants. on the side, count out how many entries there are
3. go to the first entry in the Registrants array. put everything you find in that entry into the registrant variable. keep track that you've grabbed the first entry using separate variable called index, which starts as a 0
4. do whatever is specified with that information
5. add one to the index
6. go back to the Registrants array and get the next entry, until the index is equal to the number of entries minus one
