describe 'UserShowCtrl', ->
  $controller = null
  $scope = null
  $cookies = null
  $httpBackend = null

  beforeEach ->
    module('MealOrdering')
    inject(($injector) ->
      $httpBackend = $injector.get('$httpBackend')
      $httpBackend.whenGET('/api/users?id=1').respond(Helper.user)
      $httpBackend.whenGET('/locales/pl.json').respond(Helper.locales)

    )
    inject((_$controller_, _$rootScope_) ->
      # The injector unwraps the underscores (_) from around the parameter names when matching
      $controller = _$controller_
      $scope = _$rootScope_.$new()
    )
    $controller('UserShowCtrl', { $scope: $scope })

  describe '$scope.loadUser', ->
    it 'loads user data from server', ->
      $scope.loadUser()
      $httpBackend.flush()
      expect($scope.data.user).toBe(Helpers.user)

  Helper =
    user:
      id: 1
      email: "test1@o2.pl"
      first_name: "first"
      last_name: "last"
      role: "user"
      uid: "10200124095350891"
      provider: "facebook"
      created_at: "2015-07-09T07:58:39.121Z"
      updated_at: "2015-07-09T07:58:39.121Z"

    locales:
      SESSION_NEW_SIGN_IN_TITLE: "Login"
      SESSION_NEW_SIGN_IN_WITH_FACEBOOK: "Login with facebook"
      USER_SHOW_EMAIL: "email"
      USER_SHOW_NAME: "name"
      USER_SHOW_ROLE: "role"
