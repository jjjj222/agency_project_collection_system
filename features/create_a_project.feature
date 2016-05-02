Feature: Adding a project

  As an agency
  So that I can get a project connected with a student
  I want to add a project

Background: Logged in as an approved agency
    Given I am logged in as an agency
    And I click on "My Page"
    And I press "Create Project"

Scenario: Fail to make a nameless project
  When I fill in the "Name" field with ""
  And  I press "Save Changes"
  Then I should see a notice about invalid name

Scenario:
  When I fill in the "Name" field with "New project"
  And  I fill in the "Description" field with "This is a description"
  And  I press "Save Changes"
  Then I should see a message telling me it was successful
  And  I should see "New project"
  When I click "My Page"
  Then I should see "New project"
