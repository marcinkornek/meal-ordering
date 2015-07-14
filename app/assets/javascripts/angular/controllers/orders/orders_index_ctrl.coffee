OrdersIndexCtrl = ($scope, $state, ordersData) ->

  # loading data

  $scope.loadOrders = ->
    $scope.data = {}
    ordersData.query({}
    , (orders) ->
      $scope.data.orders = orders
    , (error) ->
      console.log 'error'
      console.log error.status
      $scope.formData.error = 'There is no such consumer'
    )

  $scope.loadOrders()

angular.module('MealOrdering').controller 'OrdersIndexCtrl', OrdersIndexCtrl
OrdersIndexCtrl.$inject = ['$scope', '$state', 'ordersData']
