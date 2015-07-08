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
      url: '/users/:user_id',
      data: {
        roles: ['user']
      },
      views: {
        "header": { controller: 'GlobalHeaderCtrl', templateUrl: 'global/header.html' },
        "body":   { controller: 'UserShowCtrl',  templateUrl: 'users/user_show.html' },
      }
    })
