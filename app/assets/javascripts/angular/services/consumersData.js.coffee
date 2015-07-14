angular.module('MealOrdering').factory "consumersData", ($resource) ->
  $resource("/api/consumers/:id", {id: "@id"},
    {
      update: {method: "PUT"},
      query:  {method: "GET", isArray: true},
      loadRemainingConsumers: {method: "GET", url: '/api/remaining_consumers', isArray: true}
    }
  )
