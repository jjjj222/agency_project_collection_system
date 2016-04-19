Feature: Creating a profile as an agency

  As a non-profit
  So that I can have a profile
  I want to create a profile to be authenticated

Background: A agency with google account
  Given the Google user exist:
  | uid   | name        | email          |
  | 12345 | Google User | user@gmail.com |

Scenario: Login to create profile
  Given I am on the homepage
  When  I follow "Login"
  Then  I should be on login page
  When  I click the "Sign in with Google"
  Then  I should be on mypage
  And   I should see "Google User"
  And   I should see "user@gmail.com"
  And   I should see "Log out"
  And   I should not see "Login"
