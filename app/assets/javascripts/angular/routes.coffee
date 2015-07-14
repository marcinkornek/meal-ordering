angular.module('MealOrdering').config ($stateProvider, $urlRouterProvider) ->
  $urlRouterProvider.otherwise('/')

  $stateProvider
    .state('home', {
      url: '/',
      data: {
        roles: ['user']
      },
      views: {
        'header': { controller: 'GlobalHeaderCtrl', templateUrl: 'global/header.html' }
      }
    })
    .state('login', {
      url: '/login',
      data: {
        roles: []
      },
      views: {
        'body': { controller: 'LoginCtrl', templateUrl: 'login/login.html' }
      }
    })
    .state('users_show', {
      url: '/account',
      data: {
        roles: ['user']
      },
      views: {
        "header": { controller: 'GlobalHeaderCtrl', templateUrl: 'global/header.html' },
        "body":   { controller: 'UserShowCtrl',  templateUrl: 'users/user_show.html' },
      }
    })
    .state('consumers_index', {
      url: '/consumers',
      data: {
        roles: ['user']
      },
      views: {
        "header": { controller: 'GlobalHeaderCtrl', templateUrl: 'global/header.html' },
        "body":   { controller: 'ConsumersIndexCtrl',  templateUrl: 'consumers/consumers_index.html' },
      }
    })
