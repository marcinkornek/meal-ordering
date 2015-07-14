GlobalHeaderCtrl = ($scope, $state, $translate, $cookies, principal, sessionData) ->

  $scope.data = {}

  # functions
  $scope.destroySession = ->
    sessionData.delete((response) ->
      $scope.data = {}
      window.currentUser = {}
      principal.authenticate(null)
      $state.go('login')
    )

  # language
  $scope.setLanguage = ->
    $scope.data.locale = $cookies.get('locale') || 'pl'
    $translate.use($scope.data.locale)

  # $scope.setLanguage()

  $scope.changeLanguage = (key) ->
    $translate.use(key)
    $scope.data.locale = key
    $cookies.put('locale', key)

  # loading data
  $scope.loadData = ->
    $scope.data.user =  window.currentUser
    $scope.setLanguage()

  $scope.loadData()

angular.module('MealOrdering').controller 'GlobalHeaderCtrl', GlobalHeaderCtrl
GlobalHeaderCtrl.$inject = ['$scope', '$state', '$translate', '$cookies', 'principal', 'sessionData']
