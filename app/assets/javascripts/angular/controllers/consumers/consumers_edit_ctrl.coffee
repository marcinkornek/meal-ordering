ConsumersEditCtrl = ($scope, $state, $stateParams, consumersData) ->

  # temporary data

  $scope.loadTemporaryConsumer = ->
    $scope.formData =
      first_name: 'Loading..'
      last_name: 'Loading..'

  # loading data

  $scope.loadConsumer = ->
    consumerId = $stateParams.consumerId
    consumersData.get({id: consumerId}
    , (consumer) ->
      $scope.formData.first_name = consumer.first_name
      $scope.formData.last_name = consumer.last_name
      $scope.formData.id = consumer.id
    , (error) ->
      console.log 'error'
      console.log error
    )

  $scope.loadTemporaryConsumer()
  $scope.loadConsumer()

  # functions

  $scope.updateConsumer = (consumerId) ->
    if $scope.isFormValid()
      consumersData.update({id: consumerId}, $scope.formData
      , (success) ->
        $state.go('consumers_index')
      , (error) ->
        console.log 'error'
        console.log error
      )

  $scope.isFormValid = ->
    $scope.formData.first_name && $scope.formData.last_name

angular.module('MealOrdering').controller 'ConsumersEditCtrl', ConsumersEditCtrl
ConsumersEditCtrl.$inject = ['$scope', '$state', '$stateParams', 'consumersData']
