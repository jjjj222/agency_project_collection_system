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


Scenario: Search by project name
  Given I am on the projects page
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
  Given I am on the projects page
  When  I fill in search_value with "aaa"
  Then  I select "Agency" for search_type
  And   I press "Search"
  Then  I should see "A project"
  Then  I should see "Another name"
  Then  I should not see "Another project"

Scenario: Search by tags
  Given I am on the projects page
  When  I fill in search_value with "bcd"
  Then  I select "Tags" for search_type
  And   I press "Search"
  Then  I should see "Another project"
  Then  I should see "Another name"
  Then  I should not see "A project"
