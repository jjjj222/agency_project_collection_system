Feature: Unapproving an approved agency

  As an admin,
  I want to unapprove a agency,
  so that other tamu users can't see the agency

Background:
  Given the following TAMU Users exist:
  | name           | email         | role    | admin |
  | TAMU User Name | user@tamu.edu | student | true  |

  Given I am on the homepage
  When  I follow "Login"
  Then  I should be on login page
  When  I fill in the "Email" field with "user@tamu.edu"
  And   I press "sign_in"

  And I go to the show agency page for the current agency

Scenario:
  When I press "Unapprove Agency"
  And I go to the show agency page for the current agency
  Then there should be a button "Approve Agency"
