'use strict';

angular.module('wordhubApp')
  .factory('Repetition', function ($resource, $rootScope, $q) {
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
          response: function (response) {
            $rootScope.$broadcast('event:repetitionRun');
            return response;
          }
        }
      }
    });

    resource.getRandom = function () {
      return resource.query().$promise
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
