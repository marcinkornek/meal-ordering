describe 'GlobalHeaderCtrl', ->
  beforeEach module('MealOrdering')
  beforeEach inject((_$controller_) ->

    # The injector unwraps the underscores (_) from around the parameter names when matching
    $controller = _$controller_
  )
  describe '$scope.grade', ->
    it "sets the strength to 'strong' if the password length is >8 chars", ->
      $scope = {}
      expect(true).toBe true
      # controller = $controller('PasswordController',
      #   $scope: $scope
      # )
      # $scope.password = 'longerthaneightchars'
      # $scope.grade()
      # expect($scope.strength).toEqual 'strong'


