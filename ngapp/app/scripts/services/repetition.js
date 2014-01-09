'use strict';

angular.module('wordhubApp')
  .factory('Repetition', function ($resource, $rootScope, $q) {
    var repetitionStore;

    var resource = $resource('/api/repetitions/:id.json', {id: '@id'}, {
      patch: {
        method: 'PATCH',
        transformRequest: function (data) {
          // Delete the repetition from the store
          angular.forEach(repetitionStore, function (repetition, index) {
            if (repetition.id === data.id) {
              repetitionStore.splice(index, 1);
            }
          });
          data = {
            repetition: {
              successful: data.successful
            }
          };
          return JSON.stringify(data);
        },
        interceptor: {
          response: function (response) {
            $rootScope.$broadcast('event:repetitionRun');
            return response;
          }
        }
      }
    });

    var repetitionsPromise = function () {
      if (repetitionStore) {
        var defer = $q.defer();
        defer.resolve(repetitionStore);
        return defer.promise;
      } else {
        return resource.query().$promise
          .then(function (data) {
            console.log(data);
            repetitionStore = data;
            return data;
          });
      }
    };

    resource.getRandom = function () {
      return repetitionsPromise()
        .then(function (data) {
          if (data.length === 0) {
            return $q.reject();
          } else {
            return data[Math.floor(Math.random() * data.length)];
          }
        });
    };

    resource.update = function (repetition) {
      return repetition.$patch();
    };

    return resource;
  });
