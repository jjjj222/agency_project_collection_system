Feature: View an agency

  As a tamu user,
  I want to view a agency,
  so that I can get information of the agency and their projects

# Background: Logged in as a TAMU User on the agency page
#     Given I am logged in as a TAMU User
#     When I go to the agency page for the current agency

Scenario:
  Given I am on agencies page
  When I click "Test nonprofit"
  Then I should see "agency name" page
  And the name should be "Test nonprofit"
  And the email should be "test@testing.org"
  And the phone_number should be "123-456-7890"