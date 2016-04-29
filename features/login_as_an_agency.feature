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
  #And   I click the "Sign in with Google"
  And   I click the "google_login"
  Then  I should see "New Name"
  But   I should not see "Google User"
  And   I should see "new_address@yahoo.com"
  But   I should not see "user@gmail.com"
  And   I should see "Log out"
  And   I should not see "Login"
  When  I click "Log out"
  Then  I should see "Login"
