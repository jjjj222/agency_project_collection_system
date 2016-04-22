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
  And   I click the "Sign in with Google"
  And   I should see "Google User"
  And   I should see "user@gmail.com"
  And   I should see "Log out"
  And   I should not see "Login"

Scenario: Not logged in
  Given I am on the homepage
  Then  I should not see "My Page"
