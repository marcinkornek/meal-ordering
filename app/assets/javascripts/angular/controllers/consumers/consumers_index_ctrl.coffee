ConsumersIndexCtrl = ($scope, $state, consumersData, ngDialog) ->

  # loading data

  $scope.loadConsumers = ->
    $scope.data = {}
    consumersData.query({}
    , (consumers) ->
      $scope.data.consumers = consumers
    , (error) ->
      console.log 'error'
      console.log error.status
      $scope.formData.error = 'There is no such consumer'
    )

  $scope.loadConsumers()

  # functions

  $scope.modalDeleteConfirmation = (id) ->
    dialog = ngDialog.open
      template: 'modals/modal_delete_confirmation.html'

    dialog.closePromise.then((data) ->
      $scope.destroyConsumer(id) if data.value == 1
    )

  $scope.destroyConsumer = (consumerId) ->
    consumersData.delete(id: consumerId
    , (consumer) ->
      $scope.destroyConsumerFromConsumers(consumer.id)
    )

  $scope.destroyConsumerFromConsumers = (consumerId) ->
    $scope.data.consumers = _.reject($scope.data.consumers, (el) ->
      el.id is consumerId
    )

angular.module('MealOrdering').controller 'ConsumersIndexCtrl', ConsumersIndexCtrl
ConsumersIndexCtrl.$inject = ['$scope', '$state', 'consumersData', 'ngDialog']
