angular.module('MealOrdering').factory "ordersData", ($resource) ->
  $resource("/api/orders/:id", {id: "@id"},
    {
      update: {method: "PUT"},
      query:  {method: "GET", isArray: false},
      orderDelivered: {method: "POST", url: '/api/order_deliver'}
    }
  )
