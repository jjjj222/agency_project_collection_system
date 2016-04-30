Feature: Unapproving an approved faculty

  As an admin,
  I want to unapprove a faculty,
  so that we authenticate that all faculty are indeed memebers of the faculty

Background:
  Given I am logged in as an admin
  And I go to the show TAMU user page for the current faculty

Scenario:
  When I press "Unapprove as Faculty"
  Then I should see a message telling me it was successful
  And I go to the show TAMU user page for the current faculty
  Then there should be a button "Approve as Faculty"
