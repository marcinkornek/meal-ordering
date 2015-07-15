angular.module('MealOrdering').factory "orderService", ->

  currentCustomer = {}

  setCustomerScope: (customer) ->
    currentCustomer = customer

  getCustomerScope: ->
    currentCustomer
