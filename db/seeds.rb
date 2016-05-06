# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
example_projects = [
  { name: "ZZZ Project", description: "A completed test project", status: "completed", approved: true, agency_id: "1"},
  { name: "Test Project", description: "A completed test project", status: "completed", approved: true, agency_id: "1"},
  { name: "Test Project 2", description: "BCD", status: "completed", approved: true, agency_id: "2"},
  { name: "Test Project 5", description: "123", status: "completed", tags: ['abc', 'def'], approved: true, agency_id: "2"},
  { name: "Open Project 6", description: "BCD", status: "open", approved: true, agency_id: "2"},
  { name: "ZZZ Project 3", description: "BCD", status: "open", approved: false, agency_id: "2"},
  { name: "Test Project 3", description: "BCD", status: "open", approved: false, agency_id: "2"},
  { name: "Test Project 4", description: "BCD", status: "open", approved: false, agency_id: "3"}
]

example_users = [
  { name: "Admin", email: "admin@tamu.edu", netid: "jjjj222", role: "student", admin: true, master_admin: false},
  { name: "John Tamu", email: "john@tamu.edu", netid: "johnsnetid", role: "student", admin: false},
  { name: "Hank Tamu", email: "hank@tamu.edu", netid: "hanksnetid", role: "professor", admin: false},
  { name: "Bill Tamu", email: "bill@tamu.edu", netid: "billsnetid", role: "unapproved_professor", admin: false},
  { name: "Malini Natarajarathinam", email: "malini@tamu.edu", netid: "malinisnetid", role: "professor", admin: true, master_admin: true}
]

example_agencies = [
  { name: "Some nonprofit", email: "noprofit@gmail.com", phone_number: "979-867-5309", approved: true, provider: "fake", uid: "1" },
  { name: "Another nonprofit", email: "noprofit2@gmail.com", phone_number: "979-555-5555", approved: false, provider: "fake", uid: "2"},
  { name: "Test agency", email: "test@test.com", phone_number: "979-555-5555", provider: "test", uid: "3"}
]

# Fake admin. Netids must be 3-20 characters, so even if somehow added to production, should not be usable
fake_admin  = { name: "Admin", email: "admin@fake.org", netid: "ad", role: "professor", admin: true }
fake_master_admin  = { name: "Master Admin", email: "admin@fake.org", netid: "ma", role: "professor", admin: true, master_admin: true }


example_projects.each do |proj|
  Project.create!(proj)
end

example_users.each do |user|
  TamuUser.create!(user)
end

example_agencies.each do |agency|
  Agency.create!(agency)
end

case Rails.env
when "development"
  TamuUser.create!(fake_admin)
  TamuUser.create!(fake_master_admin)
end

def example_agencies2
  agencies = [
    { name: "Canine Companions for Independence", email: "CanineCompanionsforIndependence@nonprofit.org", approved: false }, 
    { name: "OASIS Institute", email: "OASISInstitute@nonprofit.org", approved: false }, 
    { name: "Wings of Hope", email: "WingsofHope@nonprofit.org", approved: false }, 
    { name: "ALS Association", email: "ALSAssociation@nonprofit.org", approved: false }, 
    { name: "CURE International", email: "CUREInternational@nonprofit.org", approved: true }, 
    { name: "AmeriCares", email: "AmeriCares@nonprofit.org", approved: true }, 
    { name: "Brain and Behavior Research Foundation", email: "BrainandBehaviorResearchFoundation@nonprofit.org", approved: true }, 
    { name: "National Organization for Women", email: "NationalOrganizationforWomen@nonprofit.org", approved: false }, 
    { name: "American Leprosy Missions", email: "AmericanLeprosyMissions@nonprofit.org", approved: true }, 
    { name: "Africa-America Institute", email: "Africa-AmericaInstitute@nonprofit.org", approved: false }, 
    { name: "Modest Needs", email: "ModestNeeds@nonprofit.org", approved: false }, 
    { name: "FINCA International", email: "FINCAInternational@nonprofit.org", approved: true }, 
    { name: "Ocean Conservancy", email: "OceanConservancy@nonprofit.org", approved: false }, 
    { name: "World Medical Relief", email: "WorldMedicalRelief@nonprofit.org", approved: true }, 
    { name: "Coral Reef Alliance", email: "CoralReefAlliance@nonprofit.org", approved: true }, 
    { name: "Heifer International", email: "HeiferInternational@nonprofit.org", approved: true }, 
    { name: "Operation Smile", email: "OperationSmile@nonprofit.org", approved: true }, 
    { name: "AIDS Research Alliance", email: "AIDSResearchAlliance@nonprofit.org", approved: false }, 
    { name: "Children's Hunger Fund", email: "Children'sHungerFund@nonprofit.org", approved: true }, 
    { name: "SADD", email: "SADD@nonprofit.org", approved: false }, 
    { name: "American Heart Association", email: "AmericanHeartAssociation@nonprofit.org", approved: true }, 
    { name: "Center for Responsive Politics", email: "CenterforResponsivePolitics@nonprofit.org", approved: true }, 
    { name: "Alliance for Aging Research", email: "AllianceforAgingResearch@nonprofit.org", approved: false }, 
    { name: "Big Brothers Big Sisters of America", email: "BigBrothersBigSistersofAmerica@nonprofit.org", approved: true }, 
    { name: "International Medical Corps", email: "InternationalMedicalCorps@nonprofit.org", approved: true }, 
    { name: "Easter Seals", email: "EasterSeals@nonprofit.org", approved: true }, 
    { name: "Child Welfare League of America", email: "ChildWelfareLeagueofAmerica@nonprofit.org", approved: false }, 
    { name: "Disabled American Veterans Charitable Service Trust", email: "DisabledAmericanVeteransCharitableServiceTrust@nonprofit.org", approved: true }, 
    { name: "Hearing Health Foundation", email: "HearingHealthFoundation@nonprofit.org", approved: false }, 
    { name: "Junior Achievement", email: "JuniorAchievement@nonprofit.org", approved: true }, 
    { name: "St Jude's Children's Research Hospital", email: "StJude'sChildren'sResearchHospital@nonprofit.org", approved: false }, 
    { name: "The ARC", email: "TheARC@nonprofit.org", approved: true }, 
    { name: "First Candle", email: "FirstCandle@nonprofit.org", approved: false }, 
    { name: "American Near East Refugee Aid", email: "AmericanNearEastRefugeeAid@nonprofit.org", approved: true }, 
    { name: "Farm Aid", email: "FarmAid@nonprofit.org", approved: true }, 
    { name: "Bailey House", email: "BaileyHouse@nonprofit.org", approved: true }, 
    { name: "Livestrong", email: "Livestrong@nonprofit.org", approved: false }, 
    { name: "Africa and Middle East Refugee Assistance", email: "AfricaandMiddleEastRefugeeAssistance@nonprofit.org", approved: true }, 
    { name: "American Cancer Society", email: "AmericanCancerSociety@nonprofit.org", approved: true }, 
    { name: "United Spinal Association", email: "UnitedSpinalAssociation@nonprofit.org", approved: false }, 
    { name: "National Fallen Firefighters Foundation", email: "NationalFallenFirefightersFoundation@nonprofit.org", approved: false }, 
    { name: "American Action Fund for Blind Children and Adults", email: "AmericanActionFundforBlindChildrenandAdults@nonprofit.org", approved: false }, 
    { name: "Earth Island Institute", email: "EarthIslandInstitute@nonprofit.org", approved: true }, 
    { name: "American Diabetes Association", email: "AmericanDiabetesAssociation@nonprofit.org", approved: true }, 
    { name: "Catalyst", email: "Catalyst@nonprofit.org", approved: true }, 
    { name: "Farmers and Hunters Feeding the Hungry", email: "FarmersandHuntersFeedingtheHungry@nonprofit.org", approved: false }, 
    { name: "City of Hope/Beckman Research Institute", email: "CityofHope/BeckmanResearchInstitute@nonprofit.org", approved: true }, 
    { name: "National Network to End Domestic Violence", email: "NationalNetworktoEndDomesticViolence@nonprofit.org", approved: true }, 
    { name: "Samaritan's Purse", email: "Samaritan'sPurse@nonprofit.org", approved: false }, 
    { name: "Cancer Fund of America", email: "CancerFundofAmerica@nonprofit.org", approved: false }, 
    { name: "Bowery Residents' Committee", email: "BoweryResidents'Committee@nonprofit.org", approved: false }, 
    { name: "Cancer Research Institute", email: "CancerResearchInstitute@nonprofit.org", approved: false }, 
    { name: "Asia Society", email: "AsiaSociety@nonprofit.org", approved: false }, 
    { name: "Campfire USA", email: "CampfireUSA@nonprofit.org", approved: true }, 
    { name: "Family Care International", email: "FamilyCareInternational@nonprofit.org", approved: true }, 
    { name: "Alzheimer's Association", email: "Alzheimer'sAssociation@nonprofit.org", approved: false }, 
    { name: "Refugee camp in Dadaab, Somalia", email: "RefugeecampinDadaab,Somalia@nonprofit.org", approved: true }, 
    { name: "Media Research", email: "MediaResearch@nonprofit.org", approved: true }, 
    { name: "Achilles International", email: "AchillesInternational@nonprofit.org", approved: false }, 
    { name: "Compassion International", email: "CompassionInternational@nonprofit.org", approved: true }, 
    { name: "AFS USA", email: "AFSUSA@nonprofit.org", approved: true }, 
    { name: "AMVETS National Service Foundation", email: "AMVETSNationalServiceFoundation@nonprofit.org", approved: false }, 
    { name: "Moyer Foundation", email: "MoyerFoundation@nonprofit.org", approved: true }, 
    { name: "Beyond Pesticides", email: "BeyondPesticides@nonprofit.org", approved: false }, 
    { name: "Children's Disaster Services", email: "Children'sDisasterServices@nonprofit.org", approved: true }, 
    { name: "The Sunshine Kids", email: "TheSunshineKids@nonprofit.org", approved: true }, 
    { name: "Medical Teams International", email: "MedicalTeamsInternational@nonprofit.org", approved: false }, 
    { name: "Boys and Girls Clubs of America", email: "BoysandGirlsClubsofAmerica@nonprofit.org", approved: false }, 
    { name: "Chesapeake Bay Foundation", email: "ChesapeakeBayFoundation@nonprofit.org", approved: false }, 
    { name: "Brother's Brother Foundation", email: "Brother'sBrotherFoundation@nonprofit.org", approved: false }, 
    { name: "AARP Foundation", email: "AARPFoundation@nonprofit.org", approved: false }, 
    { name: "Judicial Watch", email: "JudicialWatch@nonprofit.org", approved: true }, 
    { name: "Law Enforcement Legal Defense Fund", email: "LawEnforcementLegalDefenseFund@nonprofit.org", approved: false }, 
    { name: "Doctors Without Borders", email: "DoctorsWithoutBorders@nonprofit.org", approved: true }, 
    { name: "American Kidney Fund", email: "AmericanKidneyFund@nonprofit.org", approved: true }, 
    { name: "Environmental Defense Fund", email: "EnvironmentalDefenseFund@nonprofit.org", approved: false }, 
    { name: "Adopt a Platoon", email: "AdoptaPlatoon@nonprofit.org", approved: false }, 
    { name: "Greenpeace", email: "Greenpeace@nonprofit.org", approved: false }, 
    { name: "March of Dimes", email: "MarchofDimes@nonprofit.org", approved: true }, 
    { name: "Feed My People", email: "FeedMyPeople@nonprofit.org", approved: false }, 
    { name: "Autism Speaks", email: "AutismSpeaks@nonprofit.org", approved: false }, 
    { name: "League of Women Voters", email: "LeagueofWomenVoters@nonprofit.org", approved: true }, 
    { name: "Blue Ocean Institute", email: "BlueOceanInstitute@nonprofit.org", approved: false }, 
    { name: "City Harvest", email: "CityHarvest@nonprofit.org", approved: false }, 
    { name: "Armed Services YMCA", email: "ArmedServicesYMCA@nonprofit.org", approved: true }, 
    { name: "Center for Effective Government", email: "CenterforEffectiveGovernment@nonprofit.org", approved: true }, 
    { name: "Firefighters' Charitable Foundation", email: "Firefighters'CharitableFoundation@nonprofit.org", approved: false }, 
    { name: "Child Find of America", email: "ChildFindofAmerica@nonprofit.org", approved: true }, 
    { name: "Juvenile Diabetes Research Foundation", email: "JuvenileDiabetesResearchFoundation@nonprofit.org", approved: true }, 
    { name: "Catholic Charities USA", email: "CatholicCharitiesUSA@nonprofit.org", approved: false }, 
    { name: "National Council on Aging", email: "NationalCouncilonAging@nonprofit.org", approved: false }, 
    { name: "KaBoom!", email: "KaBoom!@nonprofit.org", approved: false }, 
    { name: "ChildFund International", email: "ChildFundInternational@nonprofit.org", approved: false }, 
    { name: "Association for Firefighters and Paramedics", email: "AssociationforFirefightersandParamedics@nonprofit.org", approved: true }, 
    { name: "Appalachian Trail Conservancy", email: "AppalachianTrailConservancy@nonprofit.org", approved: false }, 
    { name: "Action Against Hunger", email: "ActionAgainstHunger@nonprofit.org", approved: true }, 
    { name: "Seniors Coalition", email: "SeniorsCoalition@nonprofit.org", approved: false }, 
    { name: "Paralyzed Veterans of America", email: "ParalyzedVeteransofAmerica@nonprofit.org", approved: false }, 
    { name: "American Federation of Police and Concerned Citizens", email: "AmericanFederationofPoliceandConcernedCitizens@nonprofit.org", approved: false }, 
    { name: "Carbon Fund", email: "CarbonFund@nonprofit.org", approved: false }, 
    { name: "American Liver Foundation", email: "AmericanLiverFoundation@nonprofit.org", approved: false }, 
    { name: "Food Bank for New York City", email: "FoodBankforNewYorkCity@nonprofit.org", approved: false }, 
    { name: "American Brain Tumor Association", email: "AmericanBrainTumorAssociation@nonprofit.org", approved: false }, 
    { name: "Direct Relief International", email: "DirectReliefInternational@nonprofit.org", approved: false }, 
    { name: "Scholarship America", email: "ScholarshipAmerica@nonprofit.org", approved: true }, 
    { name: "Women Employed", email: "WomenEmployed@nonprofit.org", approved: true }, 
    { name: "National Children's Cancer Society", email: "NationalChildren'sCancerSociety@nonprofit.org", approved: false }, 
    { name: "National Park Foundation", email: "NationalParkFoundation@nonprofit.org", approved: false }, 
    { name: "Cancer Federation", email: "CancerFederation@nonprofit.org", approved: true }, 
    { name: "Feeding America", email: "FeedingAmerica@nonprofit.org", approved: false }, 
    { name: "Cousteau Society", email: "CousteauSociety@nonprofit.org", approved: true }, 
    { name: "International Planned Parenthood Federation", email: "InternationalPlannedParenthoodFederation@nonprofit.org", approved: true }, 
    { name: "Cambodian Children's Fund", email: "CambodianChildren'sFund@nonprofit.org", approved: true }, 
    { name: "Cancer and Careers", email: "CancerandCareers@nonprofit.org", approved: true }, 
    { name: "Building Educated Leaders for Life (BELL)", email: "BuildingEducatedLeadersforLife(BELL)@nonprofit.org", approved: false }, 
    { name: "Cedars Homes for Children", email: "CedarsHomesforChildren@nonprofit.org", approved: false }, 
    { name: "Blinded Veterans Association", email: "BlindedVeteransAssociation@nonprofit.org", approved: false }, 
    { name: "American Foundation for Disabled Children", email: "AmericanFoundationforDisabledChildren@nonprofit.org", approved: false }, 
    { name: "American Association of State Troopers", email: "AmericanAssociationofStateTroopers@nonprofit.org", approved: true }, 
    { name: "American Enterprise Institute", email: "AmericanEnterpriseInstitute@nonprofit.org", approved: false }, 
    { name: "American Rivers", email: "AmericanRivers@nonprofit.org", approved: false }, 
    { name: "Equality Now", email: "EqualityNow@nonprofit.org", approved: false }, 
    { name: "Global Fund for Women", email: "GlobalFundforWomen@nonprofit.org", approved: true }, 
    { name: "Hispanic Scholarship Fund", email: "HispanicScholarshipFund@nonprofit.org", approved: true }, 
    { name: "Lupus Research Institute", email: "LupusResearchInstitute@nonprofit.org", approved: false }, 
    { name: "National Law Enforcement Officers Memorial Fund", email: "NationalLawEnforcementOfficersMemorialFund@nonprofit.org", approved: true }, 
    { name: "ACCESS College Foundation", email: "ACCESSCollegeFoundation@nonprofit.org", approved: true }, 
    { name: "Catholic Medical Missions Board", email: "CatholicMedicalMissionsBoard@nonprofit.org", approved: true }, 
    { name: "Africare", email: "Africare@nonprofit.org", approved: false }, 
    { name: "Accuracy in Media", email: "AccuracyinMedia@nonprofit.org", approved: true }, 
    { name: "Covenant House", email: "CovenantHouse@nonprofit.org", approved: true }, 
    { name: "Keep America Beautiful", email: "KeepAmericaBeautiful@nonprofit.org", approved: true }, 
    { name: "American Lung Association", email: "AmericanLungAssociation@nonprofit.org", approved: true }, 
    { name: "CaringBridge", email: "CaringBridge@nonprofit.org", approved: true }, 
    { name: "Bright Focus Foundation", email: "BrightFocusFoundation@nonprofit.org", approved: true }, 
    { name: "Arthritis Research Institute of America", email: "ArthritisResearchInstituteofAmerica@nonprofit.org", approved: true }, 
    { name: "Epilepsy Foundation", email: "EpilepsyFoundation@nonprofit.org", approved: false }, 
    { name: "World Villages for Children", email: "WorldVillagesforChildren@nonprofit.org", approved: false }, 
    { name: "National 4-H Council", email: "National4-HCouncil@nonprofit.org", approved: false }, 
    { name: "Lutheran World Relief", email: "LutheranWorldRelief@nonprofit.org", approved: true }, 
    { name: "Boy Scouts of America", email: "BoyScoutsofAmerica@nonprofit.org", approved: false }, 
    { name: "Agros International", email: "AgrosInternational@nonprofit.org", approved: true }, 
    { name: "Children's Cancer and Blood Foundation", email: "Children'sCancerandBloodFoundation@nonprofit.org", approved: true }, 
    { name: "American Indian College Fund", email: "AmericanIndianCollegeFund@nonprofit.org", approved: false }, 
    { name: "Accion International", email: "AccionInternational@nonprofit.org", approved: false }, 
    { name: "All God's Children", email: "AllGod'sChildren@nonprofit.org", approved: true }, 
    { name: "Arthritis Foundation", email: "ArthritisFoundation@nonprofit.org", approved: true }, 
    { name: "BreastCancer.org", email: "BreastCancer.org@nonprofit.org", approved: true }, 
    { name: "Common Cause", email: "CommonCause@nonprofit.org", approved: false }, 
    { name: "International Rescue Committee", email: "InternationalRescueCommittee@nonprofit.org", approved: true }, 
    { name: "American Forests", email: "AmericanForests@nonprofit.org", approved: false }, 
    { name: "CancerCare", email: "CancerCare@nonprofit.org", approved: false }, 
    { name: "Earthjustice", email: "Earthjustice@nonprofit.org", approved: false }, 
    { name: "Breast Cancer Research Foundation", email: "BreastCancerResearchFoundation@nonprofit.org", approved: false }, 
    { name: "Cystic Fibrosis Foundation", email: "CysticFibrosisFoundation@nonprofit.org", approved: true }, 
    { name: "Huntington's Disease Society of America", email: "Huntington'sDiseaseSocietyofAmerica@nonprofit.org", approved: true }, 
    { name: "Christian Appalachian Project", email: "ChristianAppalachianProject@nonprofit.org", approved: false }, 
    { name: "Bread for the World", email: "BreadfortheWorld@nonprofit.org", approved: true }, 
    { name: "American Refugee Committee", email: "AmericanRefugeeCommittee@nonprofit.org", approved: true }, 
    { name: "Care", email: "Care@nonprofit.org", approved: true }, 
    { name: "Christopher and Dana Reeve Foundation", email: "ChristopherandDanaReeveFoundation@nonprofit.org", approved: true }, 
    { name: "American Stroke Association", email: "AmericanStrokeAssociation@nonprofit.org", approved: false }, 
    { name: "Refugee camp Dadaab in Somalia, August 15, 2011", email: "RefugeecampDadaabinSomalia,August15,2011@nonprofit.org", approved: false }, 
    { name: "Citizens Against Government Waste", email: "CitizensAgainstGovernmentWaste@nonprofit.org", approved: false }, 
    { name: "Center for Community Change", email: "CenterforCommunityChange@nonprofit.org", approved: false }, 
    { name: "Girl Scouts", email: "GirlScouts@nonprofit.org", approved: false }, 
    { name: "Children International", email: "ChildrenInternational@nonprofit.org", approved: false }, 
    { name: "Christian Relief Services", email: "ChristianReliefServices@nonprofit.org", approved: false }, 
    { name: "Dress for Success", email: "DressforSuccess@nonprofit.org", approved: true }, 
    { name: "National Relief Charities", email: "NationalReliefCharities@nonprofit.org", approved: true }, 
    { name: "Catholic Relief Services", email: "CatholicReliefServices@nonprofit.org", approved: false }, 
    { name: "Food for the Hungry", email: "FoodfortheHungry@nonprofit.org", approved: false }, 
    { name: "Habitat for Humanity", email: "HabitatforHumanity@nonprofit.org", approved: true }, 
    { name: "American Red Cross", email: "AmericanRedCross@nonprofit.org", approved: false }, 
    { name: "National Center for Missing and Exploited Children", email: "NationalCenterforMissingandExploitedChildren@nonprofit.org", approved: true }, 
    { name: "Children's Cancer Research Fund", email: "Children'sCancerResearchFund@nonprofit.org", approved: true }, 
    { name: "Coalition for the Homeless", email: "CoalitionfortheHomeless@nonprofit.org", approved: true }, 
    { name: "Air Force Aid Society", email: "AirForceAidSociety@nonprofit.org", approved: true }, 
    { name: "Center for Biological Diversity", email: "CenterforBiologicalDiversity@nonprofit.org", approved: true }, 
    { name: "Cancer Recovery Foundation", email: "CancerRecoveryFoundation@nonprofit.org", approved: true }, 
    { name: "Society of St. Andrew", email: "SocietyofSt.Andrew@nonprofit.org", approved: false }, 
    { name: "American Association of the Deaf-Blind", email: "AmericanAssociationoftheDeaf-Blind@nonprofit.org", approved: false }, 
    { name: "Jimmy Fund", email: "JimmyFund@nonprofit.org", approved: false }, 
    { name: "Emergency Nutrition Network", email: "EmergencyNutritionNetwork@nonprofit.org", approved: false }, 
    { name: "Heritage for the Blind", email: "HeritagefortheBlind@nonprofit.org", approved: false }, 
    { name: "Army Emergency Relief", email: "ArmyEmergencyRelief@nonprofit.org", approved: false }, 
    { name: "Project Sunshine", email: "ProjectSunshine@nonprofit.org", approved: true }, 
    { name: "Government Accountability Project", email: "GovernmentAccountabilityProject@nonprofit.org", approved: true }, 
    { name: "American Parkinson Disease Association", email: "AmericanParkinsonDiseaseAssociation@nonprofit.org", approved: true }, 
    { name: "American Farmland Trust", email: "AmericanFarmlandTrust@nonprofit.org", approved: true }, 
    { name: "Avon Foundation", email: "AvonFoundation@nonprofit.org", approved: false }
  ]
end

example_agencies2.take(10).each {|a| Agency.create!(a) }

def example_projs2
  projs = [
    { name: "Apollo 14", description: "Might crash." },
    { name: "RoboCode Competition", description: "Battle bots for kids!" },
    { name: "Firefighting Kitties", description: "The cutest firefighters" },
    { name: "Big Event", description: "The biggest of events!", approved: true },
    { name: "The Bigger Event", description: "Why not?" },
    { name: "The Biggest Event", description: "Because."}
  ]
end

example_projs2.each do |a|
  Project.create! a.reverse_merge(status: Project.all_statuses.sample, agency: Agency.all.sample, approved: [true,false].sample, description: "", tags: [ ["fun", "boring", "IT"].sample ])
end
