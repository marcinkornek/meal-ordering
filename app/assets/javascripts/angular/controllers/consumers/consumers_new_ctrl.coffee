ConsumersNewCtrl = ($scope, $state, consumersData) ->

  # function

  $scope.createConsumer = ->
    if $scope.isFormValid()
      consumersData.save({}, $scope.formData
      , (success) ->
        console.log success
        $state.go('consumers_index')
      , (error) ->
        console.log 'error'
        console.log error
      )

  $scope.isFormValid = ->
    $scope.formData.first_name && $scope.formData.last_name

angular.module('MealOrdering').controller 'ConsumersNewCtrl', ConsumersNewCtrl
ConsumersNewCtrl.$inject = ['$scope', '$state', 'consumersData']
