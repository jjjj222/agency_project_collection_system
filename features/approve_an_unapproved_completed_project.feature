Feature: Approving an approved completed project

  As an admin,
  I want to approve a unpproved completed project,
  so that it is fully completed

  Background:
    Given I am logged in as an admin
    And there is a uncompleted project
    And I click on "Completed Projects"
    And I click on "Test Project"
    #And I go to the show project page for the completed project
    
  Scenario:
    When I press "Approve Project Completion"
    Then I should see a message telling me it was successful
    When I click on "Test Project"
    Then there should be a button "Unapprove Project Completion"
    When I click on "Completed Projects"
    Then I should not see "Test Project"
