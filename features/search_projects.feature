Feature: View project list with filters

  As a general user
  I want to see the list of all projects based on potential filter criteria
  So that I can look at relevant projects

Background: Given projects
  Given I am logged in as a Tamu User
  Given the following projects exist:
  | name            | description    | status | tags | approved | agency  |
  | A project       | just a project | open   | abc  | true     | AAA BBB |
  | Another project | nothing        | open   | bcd  | true     | BBB CCC |
  | Another name    | just a project | open   | bcd  | true     | AAA CCC |
  Given I am on the projects page

Scenario: Search by project name
  Then  I should see "A project"
  Then  I should see "just a project"
  Then  I should see "abc"
  Then  I should see "AAA BBB"
  Then  I should see "Another project"
  Then  I should see "Another name"
  When  I fill in search_value with "project"
  And   I press "Search"
  Then  I should see "A project"
  Then  I should not see "Another name"

Scenario: Search by Agency name
  When  I fill in search_value with "aaa"
  Then  I select "Agency" for search_type
  And   I press "Search"
  Then  I should see "A project"
  Then  I should see "Another name"
  Then  I should not see "Another project"

Scenario: Search by tags
  When  I fill in search_value with "bcd"
  Then  I select "Tags" for search_type
  And   I press "Search"
  Then  I should see "Another project"
  Then  I should see "Another name"
  Then  I should not see "A project"

Scenario: Reset filter
  When  I fill in search_value with "project"
  And   I press "Search"
  Then  I should see "A project"
  Then  I should not see "Another name"
  When  I click on "All Projects"
  Then  I should see "A project"
  Then  I should see "Another project"
  Then  I should see "Another name"

Scenario: Persist search results
  When  I fill in search_value with "project"
  And   I press "Search"
  Then  I should see "A project"
  Then  I should not see "Another name"
  When  I click on "Project Name"
  Then  I should see "A project"
  Then  I should not see "Another name"


