Feature: Update tamu user contact info

  As a tamu user,
  I want to change my contact info,
  so that I can update how I am contacted

Background: Logged in as a TAMU User
  Given I am logged in as a TAMU User

Scenario:
  When I go to the edit page
  And  I fill in the "Email" field with "new@email.com"
  And  I press "Update Contact Info"
  Then the email should be "new@email.com"

