angular.module('MealOrdering').factory "sessionData", ($resource) ->
  $resource("/api/session", {})
