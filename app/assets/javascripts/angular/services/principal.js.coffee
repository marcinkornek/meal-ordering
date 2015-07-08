# ###
# http://stackoverflow.com/a/22540482/3922041
# ###

angular.module('MealOrdering').factory "principal", [ "$q", "$http", "$timeout", ($q, $http, $timeout) ->
  _identity = undefined
  _authenticated = false

  isIdentityResolved: ->
    angular.isDefined _identity

  isAuthenticated: ->
    _authenticated

  isInRole: (role) ->
    return false  if not _authenticated or not _identity.roles
    _identity.roles.indexOf(role) isnt -1

  isInAnyRole: (roles) ->
    return false  if not _authenticated or not _identity.roles
    i = 0

    while i < roles.length
      return true  if @isInRole(roles[i])
      i++
    false

  authenticate: (identity) ->
    _identity = identity
    _authenticated = identity?

  identity: (force) ->
    deferred = $q.defer()
    _identity = undefined  if force is true

    # check and see if we have retrieved the identity data from the server. if we have,
    # reuse it by immediately resolving
    if angular.isDefined(_identity)
      deferred.resolve _identity
      return deferred.promise

    # otherwise, retrieve the identity data from the server, update the identity object,
    # and then resolve.
    #                   $http.get('/svc/account/identity', { ignoreErrors: true })
    #                        .success(function(data) {
    #                            _identity = data;
    #                            _authenticated = true;
    #                            deferred.resolve(_identity);
    #                        })
    #                        .error(function () {
    #                            _identity = null;
    #                            _authenticated = false;
    #                            deferred.resolve(_identity);
    #                        });

    # for the sake of the demo, fake the lookup by using a timeout to create a valid
    # fake identity. in reality,  you'll want something more like the $http request
    # commented out above. in this example, we fake looking up to find the user is
    # not logged in
    self = this
    $timeout (->
      self.authenticate null
      deferred.resolve _identity
    ), 1000
    deferred.promise
 ]
