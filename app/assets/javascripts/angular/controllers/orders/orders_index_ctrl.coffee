OrdersIndexCtrl = ($scope, $state, ordersData, ngDialog, $cookies) ->

  # loading data

  $scope.loadFilterIdFromCookie = ->
    $scope.filterId = parseInt($cookies.get('filterId'), 10) || 1

  $scope.loadOrders = ->
    $scope.data = {}
    ordersData.query({}
    , (orders) ->
      $scope.data.allOrders = $scope.data.orders = orders.orders
      $scope.data.remainingConsumersCount = orders.remaining_consumers_count
      $scope.filterOrders($scope.filterId)
    , (error) ->
      console.log 'error'
      console.log error.status
      $scope.formData.error = 'There is no such consumer'
    )

  $scope.loadOrders()
  $scope.loadFilterIdFromCookie()

  # functions

  $scope.filters = [
    { id: 1, name: 'ORDER_INDEX_FILTER_ALL' }
    { id: 2, name: 'ORDER_INDEX_FILTER_NOT_DELIVERED' }
    { id: 3, name: 'ORDER_INDEX_FILTER_DELIVERED' }
  ]

  $scope.filterOrders = (filterId) ->
    $scope.saveFilterIdToCookie(filterId)
    switch filterId
      when 1
        $scope.data.orders = $scope.data.allOrders
      when 2
        $scope.filterOrdersBy('ordered')
      when 3
        $scope.filterOrdersBy('delivered')

  $scope.filterOrdersBy = (filter) =>
    $scope.data.orders = _.where($scope.data.allOrders, {state: filter})

  $scope.saveFilterIdToCookie = (filterId) ->
    $cookies.put('filterId', filterId)

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
    $scope.data.allOrders = _.reject($scope.data.allOrders, (el) ->
      el.id is orderId
    )
    $scope.data.remainingConsumersCount += 1

  $scope.updateOrderInOrders = (order) ->
    item = _.findWhere($scope.data.orders, { id: order.id })
    item.state = order.state

angular.module('MealOrdering').controller 'OrdersIndexCtrl', OrdersIndexCtrl
OrdersIndexCtrl.$inject = ['$scope', '$state', 'ordersData', 'ngDialog', '$cookies']
