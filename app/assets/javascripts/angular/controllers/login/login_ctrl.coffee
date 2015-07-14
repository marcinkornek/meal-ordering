LoginCtrl = ($scope, $state, sessionData) ->

  # facebook SDK

  window.fbAsyncInit = ->
    FB.Event.subscribe "auth.statusChange", (response) ->
      $scope.statusChangeCallback(response)

    FB.init
      appId: window.facebookId # App ID
      status: true # check login status
      cookie: true # enable cookies to allow the server to access the session
      xfbml: true  # parse XFBML
      version: 'v2.4'

  # Load the SDK Asynchronously
  ((d) ->
    id = "facebook-jssdk"
    ref = d.getElementsByTagName("script")[0]
    return  if d.getElementById(id)
    js = d.createElement("script")
    js.id = id
    js.async = true
    js.src = "//connect.facebook.net/en_US/sdk.js"
    ref.parentNode.insertBefore js, ref
  ) document

  # functions

  $scope.data = {}

  $scope.redirectToHomeIfLoggedIn = ->
    if window.currentUser
      $state.go('home')

  $scope.redirectToHomeIfLoggedIn()

  $scope.statusChangeCallback = (response) ->
    if response.status == 'connected' && $scope.data.login == true
      $scope.getData()

  $scope.getData = ->
    FB.api "/me",
      fields: "last_name, first_name, email, id"
    , (response) ->
      $scope.loginBackend(response)

  $scope.loginBackend = (response) ->
    response = _.extend(response, {provider: 'facebook'})
    sessionData.save({}, response
    , (success) ->
      window.currentUser = success
      $state.go('home')
    , (error) ->
      console.log 'error'
      console.log error
    )

  $scope.loginFB = ->
    $scope.data.login = true
    FB.getLoginStatus (response) =>
      if response.status != 'connected'
        FB.login($scope.statusChangeCallback(response), scope: 'email')
      else
        $scope.statusChangeCallback(response)

angular.module('MealOrdering').controller 'LoginCtrl', LoginCtrl
LoginCtrl.$inject = ['$scope', '$state', 'sessionData']
