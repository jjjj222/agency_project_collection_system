Feature: Update tamu user info

  As a tamu user,
  I want to be able to change my email, name, and role
  so that I can update how I am contacted

Background: Logged in as a TAMU User on the edit page
  Given I am logged in as a TAMU User
  When I go to the edit tamu user page for the current user

Scenario:
  When  I fill in the "tamu_user_email" field with "badEmail"
  And  I press "submit_user_form"
  Then I should see a notice about invalid email

Scenario:
  When  I fill in the "tamu_user_email" field with "new@email.com"
  And  I press "submit_user_form"
  Then I should see a message telling me it was successful
  And the email should be "new@email.com"

Scenario:
  When  I fill in the "Name" field with ""
  And  I press "submit_user_form"
  Then I should see a notice about invalid name

Scenario:
  When  I fill in the "Name" field with "New name"
  And  I press "submit_user_form"
  Then I should see a message telling me it was successful
  And the name should be "New name"

Scenario:
  When I select "Faculty" for tamu user role
  And I press "Save Changes"
  Then I should see a message telling me it was successful
  And I should see "Faculty (Unapproved)"

Scenario:
  When I select "Student" for tamu user role
  And I press "Save Changes"
  Then I should see a message telling me it was successful
  And I should see "Student"
