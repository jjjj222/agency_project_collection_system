#encoding: utf-8
Feature: Show the list of all projects
  As a Tamu User
  I want to see the list of all projects
  So that I pick one to work on

Background: Given projects
  Given I am logged in as a Tamu User
  Given the following projects exist:
  | name            | description    | status | tags | approved | agency  |
  | A project       | just a project | completed   | abc  | true     | AAA BBB |
  | Another project | nothing        | open   | bcd  | true     | BBB CCC |
  | Another name    | just a project 2 | completed   | fcd  | false     | AAA CCC |


Scenario: See completed projects
  Given I am on the projects page
  Then  I should see "A project"
  Then  I should see "just a project"
  Then  I should see "abc"
  Then  I should see "AAA BBB"
  Then  I should see "Another project"
  Then  I should see "nothing"
  Then  I should see "bcd"
  Then  I should see "BBB CCC"
  Then  I should not see "Another name"
  Then  I should not see "just a project 2"
  Then  I should not see "fcd"
  Then  I should not see "AAA CCC"
