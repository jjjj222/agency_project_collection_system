Feature: Edit a project

  As an agency,
  I want to edit a project,
  so that I can change fields for my project

  Background:
    Given I am logged in as an agency
    And I go to the edit project page for the current project

Scenario:
  When  I select "Open" for project status
  And  I press "Save Changes"
  Then I should see a message telling me it was successful
  And the status should be "open"

Scenario:
  When  I fill in the "project_name" field with ""
  And  I press "Save Changes"
  Then I should see a notice about invalid name

Scenario:
  When  I fill in the "project_name" field with "New name"
  And  I press "Save Changes"
  Then I should see a message telling me it was successful
  And the name should be "new name"

  #there is no sad path for description
Scenario:
  When  I fill in the "project_description" field with "New desc"
  And  I press "Save Changes"
  Then I should see a message telling me it was successful
  And the description should be "new desc"
  #there is no sad path for tags
Scenario:
  When  I fill in the "project_tags" field with "new-tag"
  And  I press "Save Changes"
  Then I should see a message telling me it was successful
  And the tags should be "new-tag"
