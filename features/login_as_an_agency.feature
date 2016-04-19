Feature: Logging in as an agency

  As an agency
  I want to log in through my google account
  So that I can have my own profile

Background: A agency with google account
  Given the Google user exist:
  | uid   | name        | email          |
  | 12345 | Google User | user@gmail.com |

  Given the following Agencies exist:
  | uid   | name        | email                 |
  | 12345 | New Name    | new_address@yahoo.com |

Scenario: Login to reuse profile
  Given I am on the homepage
  When  I follow "Login"
  Then  I should be on login page
  When  I click the "Sign in with Google"
  Then  I should be on mypage
  And   I should see "New Name"
  And   I should see "new_address@yahoo.com"
  And   I should see "Log out"
  And   I should not see "Login"
