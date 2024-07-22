Feature: Swapi Api

  Background:
    * configure ssl = true
    * url "https://swapi.dev/api"

  Scenario Outline: Make a query all swapi resources by page
    * def jsonResponse = read('../json/'+'<json>')
    * param myparam = "page=2"
    Given path '<path>'
    When method get
    Then status <status>
    And match response == jsonResponse

    Examples:
      | path        | status | json                |
      | /vehicles/  | 200    | vehicles_page.json  |
      | /starships/ | 200    | starships_page.json |

  Scenario Outline: Make a query all swapi resources by id
    * def jsonResponse = read('../json/'+'<json>')
    Given path '<path>'
    When method get
    Then status <status>
    And match response == jsonResponse

    Examples:
      | path          | status | json              |
      | /people/6/    | 200    | people_id.json    |
      | /vehicles/6/  | 200    | vehicles_id.json  |
      | /starships/9/ | 200    | starships_id.json |

  Scenario Outline: Make a query all swapi resources by specific search
    * def jsonResponse = read('../json/'+'<json>')
    * param myparam = "search="+'<search>'
    Given path '<path>'
    When method get
    Then status <status>
    And match response == jsonResponse

    Examples:
      | path        | search         | status | json                |
      | /people/    | R2-D2          | 200    | people_page.json    |
      | /planets/   | Tatooine       | 200    | planets_page.json   |
      | /starships/ | Death Star     | 200    | starships_page.json |

  Scenario Outline: Make a query with non-existing page
    Given path '<path>'
    When method get
    Then status 404

    Examples:
      | path        |
      | /peopl/    |
      | /plants/   |
      | /vehices/  |


  Scenario Outline: Make a query with non-existing ID
    Given path '<path>'
    When method get
    Then status 404

    Examples:
      | path          |
      | /people/999/  |
      | /planets/999/ |
    
