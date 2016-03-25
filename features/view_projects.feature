#encoding: utf-8
Feature: Show the list of all projects
  As a Tamu User
  I want to see the list of all projects
  So that I pick one to work on
  
  Background: Logged in as a TAMU User on home page
    Given I am logged in as a TAMU User
    When I go to the homepage
  
  Scenario: List all projects
    Then I should see a list of all projects
    
  Scenario: Filter projects
    When I select the programming tag
    Then I should see only projects with the programming tag
  