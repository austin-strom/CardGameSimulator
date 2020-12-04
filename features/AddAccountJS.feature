@javascript
Feature: Javascript testing
  Scenario: Checking if I'm logged in with Javascript
    Given I have create an account with username "Kevin", email "kevin@gmail.com", and password "testpassword1"
    And Javascript is enabled
    When I attempt to login with "kevin@gmail.com" and "testpassword1"
    Then I should be redirected to the "dashboard" page
    And I should be able to logout