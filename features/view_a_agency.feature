Feature: View an agency

  As a tamu user,
  I want to view a agency,
  so that I can get information of the agency and their projects

  Background:
    Given there is a current agency

Scenario:
  When I go to the agencies page
  And I click "Test nonprofit"
  Then the name should be "Test nonprofit"
  And the email should be "test@testing.org"
  And the phone_number should be "123-456-7890"
