angular.module('MealOrdering').config ($stateProvider, $urlRouterProvider) ->
  $urlRouterProvider.otherwise('/');
