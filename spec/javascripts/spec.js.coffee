#= require application
#= require jasmine
#= require jasmine-ajax
#= require jasmine-jquery
#= require angular-mocks
#= require_tree ./

jasmine.getFixtures().fixturesPath = 'fixtures'

shared = angular.module('MealOrdering')
shared.constant('Rails', { env: 'dev', templates: {} })

beforeEach ->
  module('MealOrdering', ($provide, $translateProvider) ->
    $provide.factory 'customLoader', ($q) ->
      ->
        deferred = $q.defer()
        deferred.resolve {}
        deferred.promise

    $translateProvider.useLoader 'customLoader'
    return
  )
