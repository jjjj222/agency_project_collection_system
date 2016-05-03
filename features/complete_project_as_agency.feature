Feature: Completing a project as an agency

  As an agency,
  I want to approve an open project,
  so that it is unapproved_completed

  Background:
    Given I am logged in as an agency
    And there is a current project
    And I click on "My Page"
    And I click on "Test Project"
    #And I go to the show project page for the completed project
    
  Scenario:
    When I press "Edit"
    And  I select "Completed (Pending approval)" for project status
    And  I press "Save Changes"
    Then I should see a message telling me it was successful
    And the status should be "Completed (Pending approval)"
