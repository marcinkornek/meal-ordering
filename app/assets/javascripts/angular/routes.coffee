angular.module('MealOrdering').config ($stateProvider, $urlRouterProvider) ->
  $urlRouterProvider.otherwise('/')

  $stateProvider
    .state('login', {
      url: '/login',
      data: {
        roles: []
      },
      views: {
        'body': { controller: 'LoginCtrl', templateUrl: 'login/login.html' }
      }
    })
    .state('home', {
      url: '/',
      data: {
        roles: ['user']
      },
      views: {
        'header': { controller: 'GlobalHeaderCtrl', templateUrl: 'global/header.html' }
      }
    })
