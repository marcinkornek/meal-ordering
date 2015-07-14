angular.module('MealOrdering').factory "consumersData", ($resource) ->
  $resource("/api/consumers/:id", {id: "@id"},
    {
      update: {method: "PUT"},
      query:  {method: "GET", isArray: true},
    }
  )
