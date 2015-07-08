GlobalHeaderCtrl = ($scope, $state, $translate, $cookies, principal, sessionData) ->

  # functions

  $scope.destroySession = ->
    sessionData.delete((response) ->
      $scope.data = {}
      window.currentUser = {}
      principal.authenticate(null)
      $state.go('home', {}, {reload: true})
    )

  # language

  $scope.setLanguage = ->
    $scope.data = {}
    $scope.data.locale = $cookies.locale || 'en'
    $translate.use $scope.data.locale

  $scope.setLanguage()

  $scope.changeLanguage = (key) ->
    $translate.use key
    $cookies.locale = $scope.data.locale = key

  # loading data

  $scope.loadData = ->
    $scope.data.user =  window.currentUser
    $scope.data.locale = $cookies.locale || 'pl'

  $scope.loadData()

angular.module('MealOrdering').controller 'GlobalHeaderCtrl', GlobalHeaderCtrl
GlobalHeaderCtrl.$inject = ['$scope', '$state', '$translate', '$cookies', 'principal', 'sessionData']
