Feature: Approving an unapproved agency

  As an admin,
  I want to approve a agency,
  so that other tamu users can see the agency

Background:
  Given I am logged in as an admin
  And I go to the show agency page for the unapproved agency
  
Scenario:
  When I press "Approve Agency"
  And I go to the show agency page for the unapproved agency
  Then there should be a button "Unapprove Agency"
