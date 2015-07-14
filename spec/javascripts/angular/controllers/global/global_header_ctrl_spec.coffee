describe 'GlobalHeaderCtrl', ->
  $controller = null
  $scope = null
  $cookies = null
  $httpBackend = null

  beforeEach ->
    module('MealOrdering')
    inject(($injector) ->
      $httpBackend = $injector.get('$httpBackend')
      $httpBackend.whenGET('/locales/pl.json').respond(Helper.locales)
      $httpBackend.whenDELETE('/api/session').respond(Helper.token)
    )
    inject((_$controller_, _$rootScope_, _$cookies_) ->
      # The injector unwraps the underscores (_) from around the parameter names when matching
      $controller = _$controller_
      $scope = _$rootScope_.$new()
      $cookies = _$cookies_
    )
    $controller('GlobalHeaderCtrl', { $scope: $scope })

  describe '$scope.changeLanguage', ->
    it 'sets $scope.data.locale to locale key', ->
      $scope.changeLanguage('en')
      expect($scope.data.locale).toBe('en')

    it 'sets $cookies.locale to locale key', ->
      $scope.changeLanguage('en')
      expect($cookies.locale).toBe('en')

  describe '$scope.setLanguage', ->
    describe 'when $cookies.locale empty', ->
      it 'sets $scope.data.locale to en', ->
        $cookies.locale = undefined
        $scope.setLanguage()
        expect($scope.data.locale).toBe('en')

    describe 'when $cookies.locale is present', ->
      it 'sets $scope.data.locale to $cookies.locale language', ->
        $cookies.locale = 'pl'
        $scope.setLanguage()
        $httpBackend.flush()
        expect($scope.data.locale).toBe('pl')

    describe '$scope.destroySession', ->
      it 'clears user data from $scope', ->
        $scope.data.user = Helper.user
        $scope.destroySession()
        $httpBackend.flush()
        expect($scope.data.user).toBe({})

      it 'clears user data from head', ->
        window.currentUser = Helper.user
        $scope.destroySession()
        $httpBackend.flush()
        expect(window.currentUser).toBe({})

  Helper =
    token:
      token: '123asd123asda1234543'

    user:
      id: 2
      email: 'mars124@o2.pl'
      role: 'user'

    locales:
      SESSION_NEW_SIGN_IN_TITLE: "Login"
      SESSION_NEW_SIGN_IN_WITH_FACEBOOK: "Login with facebook"
      USER_SHOW_EMAIL: "email"
      USER_SHOW_NAME: "name"
      USER_SHOW_ROLE: "role"
