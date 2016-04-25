Feature: Delete a project

  As an agency,
  I want to delete a project,
  so that I can remove a project if I no longer need it done.

Background: Logged in as an approved agency
    Given I am logged in as an agency
    Given there is a current project
    And I am on the home page
    And I click "My Page"

Scenario:
   When I click "Test Project"
   And  I press "Delete"
   Then I should not see "Test Project"
   When I click "My Page"
   Then I should not see "Test Project"
