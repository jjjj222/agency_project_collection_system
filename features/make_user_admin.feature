Feature: Make other users admins
  As an admin
  I want to be able to make another tamu user an admin
  So that they can help manage the site

Scenario:
    Given I am logged in as an admin
    And there is another current user
    When I click "TAMU Users"
    When I press "Make Admin"
    Then I should see a message telling me it was successful
    And I should not see "Make Admin"

Scenario:
    Given I am logged in as a TAMU User
    When I click "TAMU Users"
    And I should not see "Make Admin"
