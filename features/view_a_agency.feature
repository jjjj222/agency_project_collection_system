Feature: View an agency

  As a tamu user,
  I want to view a agency,
  so that I can get information of the agency and their projects

#   Background:
#     Given there is a current agency
#     Given I am logged in as a tamu user
#     #Given I am logged in as a TAMU User

# Scenario:
#   When I go to the agencies page
#   And I click "Test nonprofit"
#   Then the name should be "Test nonprofit"
#   And the email should be "test@testing.org"
#   And the phone number should be "123-456-7890"

Background:
    Given I am logged in as a tamu user
    And I go to the show agency page for the current agency

  Scenario:
    Then the name should be "Test nonprofit"
    And the email should be "test@testing.org"
    And the phone number should be "123-456-7890"