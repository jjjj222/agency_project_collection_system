Feature: Sort projects list
  TODO

Background: 
    Given I am logged in as a tamu user
    And there is a current project
    And there is a second project
    And I am on the home page
    And I click on "All Projects"

Scenario:
    When I click "Project Name"
    Then there should be a list of projects sorted by project name
