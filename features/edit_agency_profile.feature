Feature: Edit agency profile

  As an agency,
  So that I can change my profile.
  I want to be able to edit my profile

Background:
  Given I am logged in as an Agency

Scenario:
  Given I am on the homepage
  Then  I follow "My page"
  And   I should be on mypage
  Then  I follow "My Profile"
  And   I should be on my profile page
  Then  I follow "Edit"
  And   I should be on my profile edit page
  When  I fill in the "Name" field with "123"
  And   I press "submit_user_form"
  And   I should be on my profile page
  Then  I should see "123"
