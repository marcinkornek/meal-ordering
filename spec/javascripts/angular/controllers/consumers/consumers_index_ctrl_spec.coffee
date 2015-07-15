describe 'ConsumersIndexCtrl', ->
  $controller = null
  $scope = null

  beforeEach ->
    module('MealOrdering')
    inject((_$controller_, _$rootScope_) ->
      # The injector unwraps the underscores (_) from around the parameter names when matching
      $controller = _$controller_
      $scope = _$rootScope_.$new()
    )
    $controller('ConsumersIndexCtrl', { $scope: $scope })

  describe '$scope.destroyConsumerFromConsumers', ->
    beforeEach ->
      $scope.data.consumers = Helper.consumers

    it 'destroys consumer from $scope.data.consumers', ->
      $scope.destroyConsumerFromConsumers(1)
      expect($scope.data.consumers).toEqual([Helper.consumers[1]])

  Helper =
    consumers: [
      { id: 1, first_name: 'first_name1', last_name: 'last_name1', order: [] }
      { id: 2, first_name: 'first_name2', last_name: 'last_name2', order: [] }
    ]
