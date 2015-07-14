ConsumersIndexCtrl = ($scope, $state, consumersData) ->

  # loading data

  $scope.loadConsumers = ->
    $scope.data = {}
    consumersData.query({}
    , (consumers) ->
      console.log consumers
      $scope.data.consumers = consumers
    , (error) ->
      console.log 'error'
      console.log error.status
      $scope.formData.error = 'There is no such consumer'
    )

  $scope.loadConsumers()

angular.module('MealOrdering').controller 'ConsumersIndexCtrl', ConsumersIndexCtrl
ConsumersIndexCtrl.$inject = ['$scope', '$state', 'consumersData']
