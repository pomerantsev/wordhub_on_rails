'use strict';

angular.module('wordhubApp')
  .factory('Auth', function ($http, Session) {
    return {
      signIn: function (credentials) {
        return $http.post('/api/login.json',
          {email: credentials.email, password: credentials.password})
          .success(function (data) {
            if (data.success) {
              Session.signIn(data.user);
            }
          });
      },
      signOut: function () {
        return $http.delete('/api/logout.json')
          .success(function (data) {
            Session.signOut();
          });
      }
    };
  });
