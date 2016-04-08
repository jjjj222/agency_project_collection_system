Feature: Unapproving an approved agency

  As an admin,
  I want to unapprove a agency,
  so that other tamu users can't see the agency

  Background:
    Given I am logged in as an admin
    And I go to the show agency page for the current agency
    
  Scenario:
    When I press "Unapprove Agency"
    And I go to the show agency page for the current agency
    Then there should be a button "Approve Agency"