Feature: View a tamu user

  As any user,
  I want to view a tamu user,
  so that I can see their info and projects they are working on.

Background:
    Given I am logged in as a tamu user
    And I go to the show tamu user page for the current user

  Scenario:
    Then the name should be "Test Smith"
    And the email should be "test@test.org"
    And the role should be "student"
    And I should not see "Admin"
