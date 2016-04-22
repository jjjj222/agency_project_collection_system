Feature: Login as a new tamu user

  As a new user,
  I want to be able to create a profile when logging in the first time
  so that I can get started with the site.

Background:
    Given I am on the homepage
    And   I click "Login"
    Then  I click "Sign in with CAS" 

Scenario:
    When I fill in username with "newNetid"
    And  I fill in password with "some password"
    And  I press "Login"
    Then I should see "Create your profile"
