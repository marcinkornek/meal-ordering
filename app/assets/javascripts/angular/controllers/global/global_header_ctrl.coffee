GlobalHeaderCtrl = ($scope, $state, $translate, $cookies, principal, sessionData, Rails) ->

  $scope.data = {}

  # functions
  $scope.destroySession = ->
    sessionData.delete((response) ->
      $scope.data = {}
      Rails.currentUser = {}
      principal.authenticate(null)
      $state.go('login')
    )

  # language
  $scope.setLanguage = ->
    $scope.data.locale = $cookies.get('locale') || 'en'
    $translate.use($scope.data.locale)

  # $scope.setLanguage()

  $scope.changeLanguage = (key) ->
    $translate.use(key)
    $scope.data.locale = key
    $cookies.put('locale', key)

  # loading data
  $scope.loadData = ->
    $scope.data.user =  Rails.currentUser
    $scope.setLanguage()

  $scope.loadData()

angular.module('MealOrdering').controller 'GlobalHeaderCtrl', GlobalHeaderCtrl
GlobalHeaderCtrl.$inject = ['$scope', '$state', '$translate', '$cookies', 'principal', 'sessionData', 'Rails']
