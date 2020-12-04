Feature: Checking if accounts are managed correctly

  Scenario: Adding new users to the database
    Given I am on the "signup" page
    When I create an account with username "Kevin", email "kevin@gmail.com", and password "testpassword1"
    Then I should be redirected to the "login" page
  Scenario: Checking if I'm logged in
    Given I have create an account with username "Kevin", email "kevin@gmail.com", and password "testpassword1"
    When I attempt to login with "kevin@gmail.com" and "testpassword1"
    Then I should be redirected to the "dashboard" page
  Scenario: Checking failed logins
    Given I have create an account with username "KevinSteele", email "kevinsteele@gmail.com", and password "testpassword1"
    When I attempt to login with "kevin2@gmail.com" and "1"
    Then I should be redirected to the "login" page

  Scenario: Checking if I'm logged in with Javascript
    Given I have create an account with username "Kevin", email "kevin@gmail.com", and password "testpassword1"
    And Javascript is enabled
    When I attempt to login with "kevin@gmail.com" and "testpassword1"
    Then I should be redirected to the "dashboard" page
    And I should be able to logout