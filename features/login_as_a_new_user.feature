Feature: Login as a new tamu user

  As a new user,
  I want to be able to create a profile when logging in the first time
  so that I can get started with the site.

Background:
    Given I am on the homepage
    And   I click "Login"
    Then  I click "Sign in with CAS" 
    When I fill in username with "newNetid"
    And  I fill in password with "some password"
    And  I press "Login"
    Then I should see "Create your profile"

Scenario: No name
    When I press "Create profile"
    Then I should see a notice about invalid name

Scenario: No email
    When I fill in Name with "My Name"
    When I fill in Email with "badEmail"
    And  I press "Create profile"
    Then I should see a notice about invalid email

Scenario: Can leave the default email
    When I fill in Name with "My Name"
    And  I press "Create profile"
    Then I should see a message telling me it was successful

Scenario:
    When I fill in Name with "My Name"
    And  I fill in Email with "my_other_email@idk.com"
    And  I press "Create profile"
    Then I should see a message telling me it was successful
