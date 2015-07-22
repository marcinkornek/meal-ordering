describe 'OrdersIndexCtrl', ->
  $controller = null
  $scope = null
  $httpBackend = null

  beforeEach ->
    module('MealOrdering')
    inject(($injector) ->
      $httpBackend = $injector.get('$httpBackend')
      $httpBackend.when('GET', '/api/orders').respond(200, {
        orders: Helper.orders
        remaining_consumers_count: 1
        consumers_count: 2
      }, {})
      $httpBackend.when('DELETE', '/api/orders/1').respond(200, Helper.orders[0])
      $httpBackend.when('POST', '/api/order_deliver?id=1').respond(200, Helper.delivered)
    )
    inject((_$controller_, _$rootScope_, _$state_) ->
      # The injector unwraps the underscores (_) from around the parameter names when matching
      $controller = _$controller_
      $scope = _$rootScope_.$new()
      $state = _$state_
      spyOn( $state, 'go' )
      spyOn( $state, 'transitionTo' )
    )
    $controller('OrdersIndexCtrl', { $scope: $scope })

  describe '$scope.filterOrders', ->
    beforeEach ->
      $scope.data.orders = $scope.data.allOrders = Helper.orders

    describe 'when filterId = 1', ->
      it '$scope.data.orders contains all orders', ->
        $scope.filterOrders(1)
        expect($scope.data.orders).toEqual(Helper.orders)

    describe 'when filterId = 2', ->
      it '$scope.data.orders contains not delivered orders', ->
        $scope.filterOrders(2)
        expect($scope.data.orders).toEqual([Helper.orders[0]])

    describe 'when filterId = 3', ->
      it '$scope.data.orders contains delivered orders', ->
        $scope.filterOrders(3)
        expect($scope.data.orders).toEqual([Helper.orders[1]])

  describe '$scope.loadOrders', ->
    it 'loads data from server and saves in $scope.data.orders and $scope.data.allOrders', ->
      $scope.filterId = 1
      $scope.loadOrders()
      $httpBackend.flush()
      expect($scope.data.orders).toEqual(Helper.orders)
      expect($scope.data.allOrders).toEqual(Helper.orders)

  describe '$scope.destroyOrder', ->
    it 'deletes order on server', ->
      $scope.destroyOrder(1)
      $httpBackend.flush()
      expect($scope.data.orders).toEqual([Helper.orders[1]])
      expect($scope.data.allOrders).toEqual([Helper.orders[1]])

  describe '$scope.destroyOrderFromOrders', ->
    it 'deletes order from $scope.data.orders and $scope.data.allOrders', ->
      $scope.data.orders = $scope.data.allOrders = Helper.orders
      $scope.destroyOrderFromOrders(1)
      expect($scope.data.orders).toEqual([Helper.orders[1]])
      expect($scope.data.allOrders).toEqual([Helper.orders[1]])

  describe '$scope.changeState', ->
    it "updates order state to 'delivered' on server", ->
      $scope.data.orders = $scope.data.allOrders = Helper.orders
      $scope.changeState(1)
      $httpBackend.flush()
      expect($scope.data.orders[0]).toEqual(Helper.delivered)

  describe '$scope.updateOrderInOrders', ->
    it 'updates order state in $scope.data.orders and $scope.data.allOrders', ->
      $scope.data.orders = $scope.data.allOrders = Helper.orders
      $scope.updateOrderInOrders(Helper.delivered)
      expect($scope.data.orders[0]).toEqual(Helper.delivered)

  Helper =
    orders: [
      { id: 1, created_at: "2015-07-15T08:44:49.509Z", price: "1.0", product_name: "prod_name1", state: "ordered", consumer_name: "name1" }
      { id: 2, created_at: "2015-07-15T08:44:49.509Z", price: "1.0", product_name: "prod_name2", state: "delivered", consumer_name: "name1" }
    ]
    delivered:
      { id: 1, created_at: "2015-07-15T08:44:49.509Z", price: "1.0", product_name: "prod_name1", state: "delivered", consumer_name: "name1" }
