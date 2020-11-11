Feature: join a game room by room code
  As a player
  So that I can be identified by other members
  I want to be able to choose a name upon joining session

  Background:
    Given a room has been created

  Scenario: use room code to join an existing room
    Given I have entered a valid room code
    Then I should see the room associated with that code

  Scenario: use invalid room code
    Given I have entered an invalid room code
    Then I should stay on the same join room page
    And I should see a message telling me the room code was invalid
