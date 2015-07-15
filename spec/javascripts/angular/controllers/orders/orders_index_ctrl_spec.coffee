describe 'OrdersIndexCtrl', ->
  $controller = null
  $scope = null

  beforeEach ->
    module('MealOrdering')
    inject((_$controller_, _$rootScope_) ->
      # The injector unwraps the underscores (_) from around the parameter names when matching
      $controller = _$controller_
      $scope = _$rootScope_.$new()
    )
    $controller('OrdersIndexCtrl', { $scope: $scope })

  describe '$scope.filterOrders', ->
    beforeEach ->
      $scope.data.orders = $scope.data.allOrders = Helper.orders

    describe 'when filterId = 1', ->
      it '$scope.data.orders contain all orders', ->
        $scope.filterOrders(1)
        expect($scope.data.orders).toEqual(Helper.orders)

    describe 'when filterId = 2', ->
      it '$scope.data.orders contain not delivered orders', ->
        $scope.filterOrders(2)
        expect($scope.data.orders).toEqual([Helper.orders[0]])

    describe 'when filterId = 3', ->
      it '$scope.data.orders contain delivered orders', ->
        $scope.filterOrders(3)
        expect($scope.data.orders).toEqual([Helper.orders[1]])

  Helper =
    orders: [
      { id: 1, created_at: "2015-07-15T08:44:49.509Z", price: "1.0", product_name: "prod_name1", state: "ordered", consumer_name: "name1" }
      { id: 2, created_at: "2015-07-15T08:44:49.509Z", price: "1.0", product_name: "prod_name2", state: "delivered", consumer_name: "name1" }
    ]
