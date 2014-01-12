'use strict';

angular.module('wordhubApp')
  .factory('User', function ($resource, Session) {
    var resource = $resource('/api/users/:id.json', {id: '@id'}, {
      save: {
        method: 'POST',
        transformRequest: function (data) {
          data = {
            user: {
              name: data.name,
              email: data.email,
              password: data.password
            }
          };
          return JSON.stringify(data);
        },
        interceptor: {
          response: function (response) {
            if (response.data && response.data.success) {
              Session.signIn(response.data);
            }
            return response;
          }
        }
      }
    });

    return resource;
  });
