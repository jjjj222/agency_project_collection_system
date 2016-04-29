Feature: Approving an unapproved faculty

  As an admin,
  I want to approve an unapproved faculty,
  so that we authenticate that all faculty are indeed memebers of the faculty

Background:
  Given I am logged in as an admin
  And I go to the show TAMU user page for the unapproved faculty
  
Scenario:
  When I press "Approve as Faculty"
  Then I should see a message telling me it was successful
  And I go to the show TAMU user page for the unapproved faculty
  Then there should be a button "Unapprove as Faculty"
