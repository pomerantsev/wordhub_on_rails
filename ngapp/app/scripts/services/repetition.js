'use strict';

angular.module('wordhubApp')
  .factory('Repetition', function ($resource, $rootScope) {
    return $resource('/api/repetitions/:id.json', {id: '@id'}, {
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
  });
