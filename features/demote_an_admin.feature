Feature: Demote regular admins
  As a master admin
  I want to be able to remove admin status from an admin
  So that we can prevent wrongdoing

Scenario:
    Given I am logged in as a master admin
    And there is another current admin
    And I am on the homepage
    When I click "TAMU Users"
    When I press the 1st "Remove Admin"
    Then I should see a notice saying "You can't demote yourself"
    When I press the 2nd "Remove Admin"
    Then I should see a message telling me it was successful

Scenario:
    Given I am logged in as a TAMU User
    When I click "TAMU Users"
    And I should not see "Make Admin"
    And I should not see "Remove Admin"
