OrdersIndexCtrl = ($scope, $state, ordersData, ngDialog) ->

  # loading data

  $scope.loadOrders = ->
    $scope.data = {}
    ordersData.query({}
    , (orders) ->
      $scope.data.orders = orders.orders
      $scope.data.remainingConsumersCount = orders.remaining_consumers_count
    , (error) ->
      console.log 'error'
      console.log error.status
      $scope.formData.error = 'There is no such consumer'
    )

  $scope.loadOrders()

  # functions

  $scope.modalDeleteConfirmation = (id) ->
    dialog = ngDialog.open
      template: 'modals/modal_delete_confirmation.html'

    dialog.closePromise.then((data) ->
      $scope.destroyOrder(id) if data.value == 1
    )

  $scope.destroyOrder = (orderId) ->
    ordersData.delete(id: orderId
    , (consumer) ->
      $scope.destroyOrderFromOrders(consumer.id)
    )

  $scope.changeState = (orderId) ->
    ordersData.orderDelivered({id :orderId}
    , (order) ->
      $scope.updateOrderInOrders(order)
    , (error) ->
      console.log 'error'
      console.log error.status
      $scope.formData.error = 'There is no such consumer'
    )

  $scope.destroyOrderFromOrders = (orderId) ->
    $scope.data.orders = _.reject($scope.data.orders, (el) ->
      el.id is orderId
    )
    $scope.data.remainingConsumersCount += 1

  $scope.updateOrderInOrders = (order) ->
    item = _.findWhere($scope.data.orders, { id: order.id })
    item.state = order.state

angular.module('MealOrdering').controller 'OrdersIndexCtrl', OrdersIndexCtrl
OrdersIndexCtrl.$inject = ['$scope', '$state', 'ordersData', 'ngDialog']
