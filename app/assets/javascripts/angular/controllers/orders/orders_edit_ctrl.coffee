OrdersEditCtrl = ($scope, $state, $stateParams, ordersData, consumersData, $http) ->

  # temporary data

  $scope.loadTemporaryOrder = ->
    $scope.formData =
      product_name: 'Loading..'
      price: 'Loading..'

  # loading data

  $scope.loadOrder = ->
    orderId = $stateParams.orderId
    ordersData.get({id: orderId}
    , (order) ->
      console.log order
      $scope.formData.product_name = order.product_name
      $scope.formData.price = order.price
      $scope.formData.consumer = order.consumer
      $scope.formData.id = order.id
    , (error) ->
      console.log 'error'
      console.log error
    )

  $scope.loadTemporaryOrder()
  $scope.loadOrder()

  # loading data

  $scope.formData = {}

  $scope.loadRemainingConsumers = ->
    $scope.data = {}
    consumersData.loadRemainingConsumers({}
    , (consumers) ->
      $scope.data.consumers = consumers
    , (error) ->
      console.log 'error'
      console.log error.status
      $scope.formData.error = 'There is no such consumer'
    )

  $scope.loadRemainingConsumers()

  # functions

  $scope.updateOrder = ->
    $scope.formData.consumer_id = $scope.formData.consumer.id if $scope.formData.consumer
    if $scope.isFormValid()
      ordersData.update({}, $scope.formData
      , (success) ->
        console.log success
        $state.go('orders_index')
      , (error) ->
        console.log 'error'
        console.log error
      )

  $scope.isFormValid = ->
    $scope.formData.product_name && $scope.formData.price && $scope.formData.consumer_id

angular.module('MealOrdering').controller 'OrdersEditCtrl', OrdersEditCtrl
OrdersEditCtrl.$inject = ['$scope', '$state', '$stateParams', 'ordersData', 'consumersData', '$http']
