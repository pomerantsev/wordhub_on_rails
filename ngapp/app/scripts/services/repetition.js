'use strict';

angular.module('wordhubApp')
  .factory('Repetition', function ($resource, $q, RepetitionStore) {
    var repetitionsPromise = function () {
      if (RepetitionStore.query()) {
        return $q.when(RepetitionStore.query());
      } else {
        return queryRemainingRepetitions();
      }
    };

    var queryRemainingRepetitions = function () {
      return resource.query().$promise
        .then(function (data) {
          RepetitionStore.saveAll(data);
          return data;
        });
    };

    var resource = $resource('/api/repetitions/:id.json', {id: '@id'}, {
      patch: {
        method: 'PATCH',
        transformRequest: function (data) {
          data = {
            repetition: {
              successful: data.successful
            }
          };
          return JSON.stringify(data);
        },
        interceptor: {
          responseError: function (rejection) {
            if (rejection.status === 422) {
              return queryRemainingRepetitions();
            } else {
              return $q.reject(rejection);
            }
          }
        }
      }
    });

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
      RepetitionStore.removeRepetition(repetition);
      return resource.patch(repetition).$promise;
    };

    return resource;
  });
