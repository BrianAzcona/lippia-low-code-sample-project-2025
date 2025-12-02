@Client
Feature: client
  
  Background:
    Given base url https://api.clockify.me/api
    And header x-api-key = Y2MwOTE0OTYtMWVjNC00ZDdhLTkzYWYtZmE5Mjc1Yjc4ZGZj
    
    @addNewClient
    Scenario: add new client
      And call Workspace.feature@getAllWorkspaces
      And endpoint /v1/workspaces/{{idWorkspace}}/clients
      And header Content-Type = application/json
      And body jsons/bodies/addNewClient.json
      And set value "clienteAutomation" of key name in body jsons/bodies/addNewClient.json
      When execute method POST
      Then the status code should be 201
      And verify the response email 'contains' @example.com
      * define idClient = $.id
      
      @deleteClient
      Scenario: delete client
        And call Client.feature@addNewClient
        And endpoint /v1/workspaces/{{idWorkspace}}/clients/{{idClient}}
        When execute method DELETE
        Then the status code should be 200
        And  response should be name = clienteAutomation