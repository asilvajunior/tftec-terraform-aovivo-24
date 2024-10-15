# 3. Branch taxonomy definition

Date: 2021-11-11

## Status

Accepted

## Context

We need to document the way in which the repository branches will be created to make clear everything that was worked on in the repository in relation to the project.

## Decision

The naming pattern for branches follows the following model:

```<Work Item Type>/<Workitem Id>-<description>```

For this purpose, the following pattern will be adopted, according to the existing work items in this project:

|Work Item|Branch Pattern|
|--|--|
|Feature|FT|
|Backlog Item|BI|
|Task|TK|
|Bug|BG|

Examples:

- ```TK/1234-task-do-boards```
<br>
- ```BI/4321-backlog-item-do-boards```

In the examples above, "TK" and "BI" represent the types of their work items, being "Task" and "Backlog Item", respectively. Right after, the number that represents the ID of the work item can be seen accompanied by its respective description.

## Consequences

By standardizing the way branches will be created adopting the proposed method, everything that was done in the repository in relation to work items will be easily identifiable and clear.