Feature: Unapproved agencies can't add a project

  As an admin
  So that only agencies I approved can post projects
  I want unapproved agencies not to be able to post projects

Background: Logged in as an unapproved agency
    Given I am logged in as an unapproved agency
    And  I am on the home page

Scenario: Should not see create project
    When I click "My Page"
    Then I should not see "Create Project"
