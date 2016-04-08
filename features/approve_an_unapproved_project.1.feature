Feature: Approving an unapproved project

  As an admin,
  I want to approve a project,
  so that other tamu users can see the project

  Background:
    Given I am logged in as an admin
    And I go to the show project page for the unapproved project
    
  Scenario:
    When I press "Approve Project"
    And I go to the show project page for the current project
    Then there should be a button "Unapprove Project"