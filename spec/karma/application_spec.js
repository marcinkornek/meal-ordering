//= require application
//= require angular-mocks

shared = angular.module('MealOrdering')
shared.constant('Rails', { env: 'dev', templates: {} })

beforeEach(function() {
  return module('MealOrdering', function($provide, $translateProvider) {
    $provide.factory('customLoader', function($q) {
      return function() {
        var deferred;
        deferred = $q.defer();
        deferred.resolve({});
        return deferred.promise;
      };
    });
    $translateProvider.useLoader('customLoader');
  });
});
