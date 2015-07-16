describe 'ConsumersIndexCtrl', ->
  $controller = null
  $scope = null
  $httpBackend = null

  beforeEach ->
    module('MealOrdering')
    inject(($injector) ->
      $httpBackend = $injector.get('$httpBackend')
      $httpBackend.when('GET', '/api/consumers').respond(200, Helper.consumers)
      $httpBackend.when('DELETE', '/api/consumers/1').respond(200, Helper.consumers[0])
    )
    inject((_$controller_, _$rootScope_, _$state_) ->
      # The injector unwraps the underscores (_) from around the parameter names when matching
      $controller = _$controller_
      $scope = _$rootScope_.$new()
      $state = _$state_
      spyOn( $state, 'go' )
      spyOn( $state, 'transitionTo' )
    )
    $controller('ConsumersIndexCtrl', { $scope: $scope })

  describe '$scope.loadConsumers', ->
    it 'loads data from server and saves in $scope.data.consumers', ->
      $scope.loadConsumers()
      $httpBackend.flush()
      expect(JSON.stringify($scope.data.consumers)).toEqual(JSON.stringify(Helper.consumers))

  describe '$scope.destroyConsumer', ->
    it 'deletes order on server', ->
      $scope.destroyConsumer(1)
      $httpBackend.flush()
      expect(JSON.stringify($scope.data.consumers)).toEqual(JSON.stringify([Helper.consumers[1]]))

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
