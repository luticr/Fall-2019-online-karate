Feature: Spartan API tests
  Background: setup
    * url 'http://54.196.47.224:8000'
    * header Authorization = call read('basic-auth.js') { username: 'admin', password: 'admin' }
  Scenario: Get all spartans
    Given path '/api/spartans'
    When method get
    Then status 200
    * print karate.pretty(response)

  Scenario: Add new spartan and verify status code
    Given path '/api/spartans'
    * def spartan =
    """
      {
      "name": "Karate Master",
      "gender": "Male",
      "phone": 234512312412
       }
    """
    And request spartan
    When method post
    Then status 201
    And print karate.pretty(response)

  #  Scenario: Delete spartan
  #  Given path '/api/spartans/208'
  #   When method delete
   #  Then status 204
  # * request spartan - body of request
  # * def spartan = read('spartan.json') - spartan is a variable

  Scenario: Add new spartan from external JSON file
    Given path '/api/spartans'
    * def spartan = read('spartan.json')
    * request spartan
    When method post
    And print karate.pretty(response)
    Then status 201
    And assert response.success == 'A Spartan is Born!'

    Scenario: Update spartan
      Given path '/api/spartans/580'
      And request {name: 'Karate Master'}
      And method patch
      * print karate.pretty(responseHeaders)
      Then status 204
      * header Authorization = token
      * path '/api/spartans/580'
      When method get
      * print karate.pretty(response)
