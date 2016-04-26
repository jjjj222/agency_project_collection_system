Feature: Subscribe to a project
  As a TAMU User
  I want to be able to join a project
  So that I can work on it

Background:
    Given I am logged in as a tamu user
    And there is a current project
    And I am on the home page
    And I click on "All Projects"

Scenario:
    When I click "Test Project"
    Then I should see "some desc"
    When I press "Join Project"
    Then I should see a message telling me it was successful
    And  I should not see anything with "Join Project"
    And  I should see something with "Drop Project"
    When I click on "My Page"
    Then I should see "Test Project"
