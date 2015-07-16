describe 'GlobalHeaderCtrl', ->
  $controller = null
  $scope = null
  $cookies = null
  $httpBackend = null

  beforeEach ->
    inject(($injector) ->
      $httpBackend = $injector.get('$httpBackend')
      $httpBackend.whenDELETE('/api/session').respond(200, Helper.token, {})
    )
    inject((_$controller_, _$rootScope_, _$cookies_, _$state_) ->
      # The injector unwraps the underscores (_) from around the parameter names when matching
      $controller = _$controller_
      $scope = _$rootScope_.$new()
      $cookies = _$cookies_
      $state = _$state_
      spyOn( $state, 'go' )
      spyOn( $state, 'transitionTo' )
    )
    $controller('GlobalHeaderCtrl', { $scope: $scope })

  describe '$scope.changeLanguage', ->
    it 'sets $scope.data.locale to locale key', ->
      $scope.changeLanguage('pl')
      expect($scope.data.locale).toBe('pl')

    it 'sets $cookies.locale to locale key', ->
      $scope.changeLanguage('pl')
      expect($cookies.get('locale')).toBe('pl')

  describe '$scope.setLanguage', ->
    describe 'when $cookies.locale empty', ->
      it 'sets $scope.data.locale to en', ->
        $cookies.remove('locale')
        $scope.setLanguage()
        expect($scope.data.locale).toBe('en')

    describe 'when $cookies.locale is present', ->
      it 'sets $scope.data.locale to $cookies.locale language', ->
        $cookies.put('locale', 'pl')
        $scope.setLanguage()
        expect($scope.data.locale).toBe('pl')

    describe '$scope.destroySession', ->
      it 'clears user data from $scope', ->
        $scope.data.user = Helper.user
        $scope.destroySession()
        $httpBackend.flush()
        expect($scope.data.user).toEqual(undefined)

      it 'clears user data from head', ->
        window.currentUser = Helper.user
        $scope.destroySession()
        $httpBackend.flush()
        expect(window.currentUser).toEqual(Object {})

  Helper =
    token:
      token: '123asd123asda1234543'

    user:
      id: 2
      email: 'mars124@o2.pl'
      role: 'user'
