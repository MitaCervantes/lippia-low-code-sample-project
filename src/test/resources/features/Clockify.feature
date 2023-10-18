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
    And validate schema workspaces.json
    * define idworkspace = $.[0].id

  @ListarProyectos
  Scenario: Listar proyectos
    Given call Clockify.feature@ListarWorkSpace
    And base url env.base_url_clockify
    And endpoint /v1/workspaces/{{idworkspace}}/projects
    When execute method GET
    Then the status code should be 200
    * define idproyecto = $.[0].id

  @FallaListarProyectos
  Scenario: Falla listar proyectos
    Given call Clockify.feature@ListarWorkSpace
    And base url env.base_url_clockify
    And endpoint /v1/workspaces/projects
    When execute method GET
    Then the status code should be 404
    And response should be error = Not Found



  @CrearProyecto
  Scenario: Crear proyecto en workspace
    Given call Clockify.feature@ListarWorkSpace
    And base url env.base_url_clockify
    And endpoint /v1/workspaces/{{idworkspace}}/projects
    And set value "Project2" of key name in body addProject.json
    When execute method POST
    Then the status code should be 201

  @FallaCrearProyectoPathNoEnviado
  Scenario: Falla listar proyectos path no enviado
    Given call Clockify.feature@ListarWorkSpace
    And base url env.base_url_clockify
    And endpoint /v1/workspaces/projects
    When execute method POST
    Then the status code should be 404
    And response should be error = Not Found

  @FallaCrearProyectoBodyNoEnviado
  Scenario: Falla listar proyectos body no enviado
    Given call Clockify.feature@ListarWorkSpace
    And base url env.base_url_clockify
    And endpoint /v1/workspaces/{{idworkspace}}/projects
    When execute method POST
    Then the status code should be 400
    And response should be code = 3002



  @EliminarProyecto
  Scenario: Eliminar proyecto
    Given call Clockify.feature@ListarProyectos
    And call Clockify.feature@EditarCampoProyecto
    And base url env.base_url_clockify
    And endpoint /v1/workspaces/{{idworkspace}}/projects/{{idproyecto}}
    When execute method DELETE
    Then the status code should be 200

  @FallaEliminarProyecto
  Scenario: Falla listar proyectos
    Given call Clockify.feature@ListarProyectos
    And base url env.base_url_clockify
    And endpoint /v1/workspaces/{{idworkspace}}/projects/{{idproyecto}}
    When execute method DELETE
    Then the status code should be 400
    And response should be message = Cannot delete an active project



  @ConsultarProyectoPorId
  Scenario: Consultar proyecto por ID
    Given call Clockify.feature@ListarProyectos
    And base url env.base_url_clockify
    And endpoint /v1/workspaces/{{idworkspace}}/projects/{{idproyecto}}
    When execute method GET
    Then the status code should be 200

  @FallaConsultarProyecto
  Scenario: Falla consultar proyectos
    Given call Clockify.feature@ListarProyectos
    And base url env.base_url_clockify
    And endpoint /v1/workspaces/projects/{{idproyecto}}
    When execute method GET
    Then the status code should be 404
    And response should be error = Not Found



  @EditarCampoProyecto
  Scenario: Editar un campo del proyecto
    Given call Clockify.feature@ListarProyectos
    And base url env.base_url_clockify
    And endpoint /v1/workspaces/{{idworkspace}}/projects/{{idproyecto}}
    And set value true of key archived in body updateProject.json
    When execute method PUT
    Then the status code should be 200
    And response should be archived = true

  @FallaEditarCampoProyecto
  Scenario: Falla editar campo proyecto path no enviado
    Given call Clockify.feature@ListarProyectos
    And base url env.base_url_clockify
    And endpoint /v1/workspaces/{{idworkspace}}/projects/
    When execute method PUT
    Then the status code should be 405
    And response should be message = Request method 'PUT' is not supported

  @FallaEditarProyecto
  Scenario: Falla editar campo proyecto body vacio
    Given call Clockify.feature@ListarProyectos
    And base url env.base_url_clockify
    And endpoint /v1/workspaces/{{idworkspace}}/projects/{{idproyecto}}
    When execute method PUT
    Then the status code should be 400
    And response should be code = 3002

