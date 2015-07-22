angular.module('MealOrdering', [
  'ui.router',
  'jmdobry.angular-cache',
  'pascalprecht.translate',
  'ngResource',
  'ui.bootstrap',
  'ngCookies',
  'ngDialog',
  'ui.select',
  'ngSanitize',
  'angularMoment',
])
  .factory 'railsLocalesLoader', ($http) ->
    (options) ->
      $http.get("locales/#{options.key}.json").then (response) ->
        response.data
      , (error) ->
        throw options.key

  .config ($locationProvider) ->
    $locationProvider.html5Mode true

  .config ($provide, $httpProvider, $translateProvider, Rails) ->

    # Template cache
    if Rails.env != 'development'
      $provide.service '$templateCache', ['$angularCacheFactory', ($angularCacheFactory) ->
        $angularCacheFactory('templateCache', {
          maxAge: 3600000 * 24 * 7,
          storageMode: 'localStorage',
          recycleFreq: 60000
        })
      ]

    # Assets interceptor
    $provide.factory 'railsAssetsInterceptor', ($angularCacheFactory) ->
      request: (config) ->
        if assetUrl = Rails.templates[config.url]
          config.url = assetUrl
        config

    $httpProvider.interceptors.push('railsAssetsInterceptor')

    # Angular translate
    $translateProvider.useLoader('railsLocalesLoader')
    $translateProvider.preferredLanguage('en')
    $translateProvider.useSanitizeValueStrategy('escaped')

  .constant('angularMomentConfig', {
    preprocess: 'utc',
    timezone: 'Europe/Berlin'
  })

# ###
# http://stackoverflow.com/a/22540482/3922041
# ###

angular.module('MealOrdering').run([ "$rootScope", "$state", "$stateParams", "authorization", "principal", "Rails", ($rootScope, $state, $stateParams, authorization, principal, Rails) ->
  $rootScope.$on "$stateChangeStart", (event, toState, toParams, fromState, fromParams) ->
    $rootScope.toState = toState
    $rootScope.toStateParams = toParams
    if Rails.currentUser.id
      principal.authenticate
        username: Rails.currentUser.username
        roles: [ Rails.currentUser.role ]
    else
      principal.authenticate(null)
    authorization.authorize()
  $rootScope.$on "$stateChangeSuccess", (event, toState, toParams, fromState, fromParams) ->
])
