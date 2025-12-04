@Project
  Feature: Project
  
  Background:
    Given base url https://api.clockify.me/api
    And header x-api-key = Y2MwOTE0OTYtMWVjNC00ZDdhLTkzYWYtZmE5Mjc1Yjc4ZGZj
    
    @GetAllProjectsOnWorkspace
    Scenario: Get all projects on workspace
      And call Workspace.feature@getAllWorkspaces
      And endpoint /v1/workspaces/{{idWorkspace}}/projects
      When execute method GET
      Then the status code should be 200
      * define idProject = $[0].id
    
   @addNewProject
   Scenario: Add a new project
     And call Workspace.feature@getAllWorkspaces
     And endpoint /v1/workspaces/{{idWorkspace}}/projects
     And header Content-Type = application/json
     And body jsons/bodies/addNewProject.json
     And set value "Proyecto Automático 2" of key name in body jsons/bodies/addNewProject.json
     When execute method POST
     Then the status code should be 201
     
   @FindProjectByID
   Scenario: Find project by ID
     And call Project.feature@GetAllProjectsOnWorkspace
     And endpoint /v1/workspaces/{{idWorkspace}}/projects/{{idProject}}
     When execute method GET
     Then the status code should be 200
     * print response
     
     @UpdateProjectOnWorkspace
     Scenario: Update project on workspace
       And call Project.feature@GetAllProjectsOnWorkspace
       And endpoint /v1/workspaces/{{idWorkspace}}/projects/{{idProject}}
       And header Content-Type = application/json
       And body jsons/bodies/updateProject.json
       And set value "Proyecto Modificado 1" of key name in body jsons/bodies/updateProject.json
       When execute method PUT
       Then the status code should be 200
       And response should be $.name = Proyecto Modificado 1
       
   
     