UserShowCtrl = ($scope, $state, usersData) ->

  # loading data

  $scope.loadUser = ->
    $scope.data = {}
    # I send id: 1, but in controller I return 'current_user'
    usersData.get({id: 1}
    , (user) ->
      $scope.data.user = user
    , (error) ->
      console.log 'error'
      console.log error.status
      $scope.formData.error = 'There is no such user'
    )

  $scope.loadUser()

angular.module('MealOrdering').controller 'UserShowCtrl', UserShowCtrl
UserShowCtrl.$inject = ['$scope', '$state', 'usersData']
