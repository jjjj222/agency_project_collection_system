Feature: Viewing a project

  As a tamu user,
  I want to view a project,
  so that I can see projects I'm interested in

  Background:
    Given I am logged in as an agency
    And I go to the show project page for the current project

  Scenario:
    Then the name should be "Test project"
    And the description should be "some desc"
    And the status should be "open"
    And the tags should be ""
    And the agency should be "test nonprofit"
