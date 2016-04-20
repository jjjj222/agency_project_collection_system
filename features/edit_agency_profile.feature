Feature: Edit agency profile

  As an agency,
  So that I can change my profile.
  I want to be able to edit my profile

Background:
  Given I am logged in as an Agency

Scenario:
  Given I am on the homepage
  Then  I follow "My Page"
  Then  I follow "My Profile"
  Then  I follow "Edit"
  When  I fill in the "Name" field with "123"
  And   I press "submit_user_form"
  Then  I should see "123"
