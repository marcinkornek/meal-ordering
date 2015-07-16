describe 'UserShowCtrl', ->
  $controller = null
  $scope = null
  $httpBackend = null

  beforeEach ->
    module('MealOrdering')
    inject(($injector) ->
      $httpBackend = $injector.get('$httpBackend')
      $httpBackend.when('GET', '/api/users?id=1').respond(200, Helper.user, {})
    )
    inject((_$controller_, _$rootScope_, _$state_) ->
      # The injector unwraps the underscores (_) from around the parameter names when matching
      $controller = _$controller_
      $scope = _$rootScope_.$new()
      $state = _$state_
      spyOn( $state, 'go' )
      spyOn( $state, 'transitionTo' )
    )
    $controller('UserShowCtrl', { $scope: $scope })

  describe '$scope.loadUser', ->
    it 'sets $scope.data.user to loaded data', ->
      $scope.loadUser()
      $httpBackend.flush()
      expect(JSON.stringify($scope.data.user)).toEqual(JSON.stringify(Helper.user))

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
