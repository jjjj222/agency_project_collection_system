Feature: Logging in as an agency

  As an agency
  I want to log in through my google account
  So that I can have my own profile

Scenario:
  Given I am on the homepage
  When  I follow "Login"
  Then  I should be on login page
  When  I click the "Sign in with Google"
  Then  I should be on mypage
  And   I should see "logged in as"
