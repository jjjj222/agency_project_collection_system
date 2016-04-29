Feature: Seeing completed projects

  As the public
  So that I can see the completed projects
  I want to go to a page with completed projects without logging in


Background: Given projects

  Given the following projects exist:
  | name            | description    | status | tags | approved | agency  |
  | A project       | just a project | completed   | abc  | true     | AAA BBB |
  | Another project | nothing        | open   | bcd  | true     | BBB CCC |
  | Another name    | just a project 2 | completed   | fcd  | false     | AAA CCC |


Scenario: See completed projects
  Given I am on the home page
  Then  I should see "A project"
  Then  I should see "just a project"
  Then  I should see "abc"
  Then  I should see "AAA BBB"
  Then  I should not see "Another project"
  Then  I should not see "nothing"
  Then  I should not see "bcd"
  Then  I should not see "BBB CCC"
  Then  I should not see "Another name"
  Then  I should not see "just a project 2"
  Then  I should not see "fcd"
  Then  I should not see "AAA CCC"
