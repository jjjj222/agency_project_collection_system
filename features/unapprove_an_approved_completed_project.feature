Feature: Unapproving an approved completed project

  As an admin,
  I want to unapprove a completed project,
  so that it is no longer fully completed as a change has been made

  Background:
    Given I am logged in as an admin
    And there is a completed project
    And I click on "Home"
    And I click on "Projects"
    And I click on "Test Project"
    
  Scenario:
    When I press "Unapprove Project Completion"
    Then I should see a message telling me it was successful
    When I click on "Test Project"
    Then there should be a button "Approve Project Completion"
    When I click on "Completed Projects"
    Then I should see "Test Project"
