@Sample
Feature: Sample

  Background:
    And header Content-Type = application/json
    And header Accept = */*
    And header x-api-key = MWQ4ODMwYmYtMGQyOC00OWYyLWIzYjAtYWEzNjI4MWM4ZmUx


  @ListarWorkSpace
  Scenario: Listar Espacio de Trabajo
    Given base url env.base_url_clockify
    And endpoint /v1/workspaces
    When execute method GET
    Then the status code should be 200
    * define idworkspace = $.[0].id

  @ListarProyectos
  Scenario: Crear proyecto en workspace
    Given call Clockify.feature@ListarWorkSpace
    And base url env.base_url_clockify
    And endpoint /v1/workspaces/{{idworkspace}}/projects
    When execute method GET
    Then the status code should be 200
    * define idproyecto = $.[0].id

  @FallaListarProyectos
  Scenario: Crear proyecto en workspace
    Given call Clockify.feature@ListarWorkSpace
    And base url env.base_url_clockify
    And endpoint /v1/workspaces/{{idworkspace}}/projects
    When execute method GET
    Then the status code should be 200
    * define idproyecto = $.[0].id


  @CrearProyecto
  Scenario: Crear proyecto en workspace
    Given call Clockify.feature@ListarWorkSpace
    And base url env.base_url_clockify
    And endpoint /v1/workspaces/{{idworkspace}}/projects
    And set value "Project1" of key name in body addProject.json
    When execute method POST
    Then the status code should be 201


  @ConsultarProyectoPorId
  Scenario: Crear proyecto en workspace
    Given call Clockify.feature@ListarProyectos
    And base url env.base_url_clockify
    And endpoint /v1/workspaces/{{idworkspace}}/projects/{{idproyecto}}
    When execute method GET
    Then the status code should be 200


  @EditarCampoProyecto
  Scenario: Editar un campo del proyecto
    Given call Clockify.feature@ListarProyectos
    And base url env.base_url_clockify
    And endpoint /v1/workspaces/{{idworkspace}}/projects/{{idproyecto}}
    And set value "Project02" of key name in body updateProject.json
    When execute method PUT
    Then the status code should be 200
    And response should be name = Project02


      

  
