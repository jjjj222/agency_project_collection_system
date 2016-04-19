Feature: Edit agency profile

  As an agency,
  So that I can change my profile.
  I want to be able to edit my profile

Background:
  Given I am logged in as an Agency

Scenario:
  Given I am on the homepage
  When  I follow "My page"
  Then  I should be on mypage
