Feature: Unapproving an approved project

  As an admin,
  I want to unapprove a project,
  so that other tamu users can't see the project

  Background:
    Given I am logged in as an admin
    And I go to the show project page for the current project
    
  Scenario:
    When I press "Unapprove Project"
    Then I should see a message telling me it was successful
    When I go to the show project page for the current project
    Then there should be a button "Approve Project"
