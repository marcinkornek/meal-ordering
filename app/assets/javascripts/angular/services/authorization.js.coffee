# ###
# http://stackoverflow.com/a/22540482/3922041
# ###

angular.module('MealOrdering').factory "authorization", [ "$rootScope", "$state", "principal", ($rootScope, $state, principal) ->
  authorize: ->
    isLoggedIn = @isLoggedIn
    principal.identity()
      .then ->
        isAuthenticated = principal.isAuthenticated()
        if isLoggedIn()
          if isAuthenticated # user is signed in but not authorized for desired state
            $state.go('home')
          else
            # user is not authenticated. stow the state they wanted before you
            # send them to the signin state, so you can return them when you're done
            $rootScope.returnToState = $rootScope.toState
            $rootScope.returnToStateParams = $rootScope.toStateParams

            # now, send them to the signin state so they can log in
            $state.go 'login'

  isLoggedIn: ->
    roles = $rootScope.toState.data.roles
    !_.isEmpty(roles) && !principal.isInAnyRole(roles)
 ]
