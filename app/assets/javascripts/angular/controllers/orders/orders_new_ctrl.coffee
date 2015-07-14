OrdersNewCtrl = ($scope, $state, ordersData, consumersData, $http) ->

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

  # function

  $scope.createOrder = ->
    $scope.formData.consumer_id = $scope.formData.consumer.id
    if $scope.isFormValid()
      ordersData.save({}, $scope.formData
      , (success) ->
        console.log success
        $state.go('orders_index')
      , (error) ->
        console.log 'error'
        console.log error
      )

  $scope.isFormValid = ->
    $scope.formData.product_name && $scope.formData.price && $scope.formData.consumer_id

  $scope.country = {}
  $scope.countries = [
    name: "Afghanistan"
    code: "AF"
  ,
    name: "Åland Islands"
    code: "AX"
  ]

angular.module('MealOrdering').controller 'OrdersNewCtrl', OrdersNewCtrl
OrdersNewCtrl.$inject = ['$scope', '$state', 'ordersData', 'consumersData', '$http']
