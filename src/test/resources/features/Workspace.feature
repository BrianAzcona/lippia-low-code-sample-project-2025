@Clockify
  Feature: Clockify
    
    Background:
      Given base url https://api.clockify.me/api
      And header x-api-key = Y2MwOTE0OTYtMWVjNC00ZDdhLTkzYWYtZmE5Mjc1Yjc4ZGZj
      
    @getAllWorkspaces
    Scenario: get all my workspaces
      And  endpoint /v1/workspaces
      When execute method GET
      Then the status code should be 200
      * define idWorkspace = $[0].id
      
    @getWorkspaceInfo
    Scenario: Get Workspace Info
      And call Workspace.feature@getAllWorkspaces
      And  endpoint /v1/workspaces/{{idWorkspace}}
      When execute method GET
      Then the status code should be 200
      And response should be $.name = Crowdar
      * print response
      