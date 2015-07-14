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
    .state('consumers_new', {
      url: '/consumers/new',
      data: {
        roles: ['user']
      },
      views: {
        "header": { controller: 'GlobalHeaderCtrl', templateUrl: 'global/header.html' },
        "body":   { controller: 'ConsumersNewCtrl',  templateUrl: 'consumers/consumers_new.html' },
      }
    })
    .state('consumers_edit', {
      url: '/consumers/:consumerId/edit',
      data: {
        roles: ['user']
      },
      views: {
        "header": { controller: 'GlobalHeaderCtrl', templateUrl: 'global/header.html' },
        "body":   { controller: 'ConsumersEditCtrl',  templateUrl: 'consumers/consumers_edit.html' },
      }
    })
