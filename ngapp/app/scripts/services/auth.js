'use strict';

angular.module('wordhubApp')
  .factory('Auth', function ($http, Session, SETTINGS, $rootScope, $translate) {
    return {
      signIn: function (credentials) {
        return $http.post('/api/login.json',
          {email: credentials.email, password: credentials.password})
          .then(function (response) {
            if (response.data && response.data.success) {
              Session.signIn(response.data.user);
            }
            return response.data;
          }, SETTINGS.broadcastBackendError($rootScope, $translate));
      },
      signOut: function () {
        return $http.delete('/api/logout.json')
          .then(function () {
            Session.signOut();
          }, SETTINGS.broadcastBackendError($rootScope, $translate));
      }
    };
  });
