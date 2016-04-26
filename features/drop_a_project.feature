Feature: Drop a project
  As a TAMU User
  I want to be able to drop a project
  So that I can stop working on it

Background: I am a user working on a project
    Given I am logged in as a tamu user
    And there is a current project
    And I am on the home page
    And I click on "All Projects"
    When I click "Test Project"
    Then I should see "some desc"
    When I press "Join Project"
    Then I should see a message telling me it was successful

Scenario:
    When I press "Drop Project"
    Then I should see something with "Join Project"
    And I should see a message telling me it was successful
