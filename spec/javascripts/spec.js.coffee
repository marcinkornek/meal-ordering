#= require application
#= require jasmine
#= require jasmine-ajax
#= require jasmine-jquery
#= require angular-mocks
#= require_tree ./

jasmine.getFixtures().fixturesPath = 'fixtures'

shared = angular.module('MealOrdering')
shared.constant('Rails', { env: 'dev' })
