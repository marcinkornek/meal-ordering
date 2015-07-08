angular.module('MealOrdering').factory "usersData", ($resource) ->
  $resource("/api/users", {})
