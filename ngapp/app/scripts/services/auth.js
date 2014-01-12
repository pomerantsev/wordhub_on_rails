'use strict';

angular.module('wordhubApp')
  .factory('Auth', function ($http, Session, $q, $rootScope, $timeout) {
    // Experimental. Checks for session status updates.
    // Better to implement long polling.
    var scheduleSessionQuery = function () {
      $timeout(function () {
        querySession();
        scheduleSessionQuery();
      }, 60000);
    };

    var querySession = function () {
      return $http.get('/api/session.json')
        .then(function (response) {
          if (response.data && response.data.success) {
            Session.signIn(response.data);
            return response;
          } else {
            Session.signOut();
            return $q.reject();
          }
        });
    };

    var service = {
      signIn: function (credentials) {
        return $http.post('/api/login.json',
          {email: credentials.email, password: credentials.password})
          .then(function (response) {
            if (response.data && response.data.success) {
              Session.signIn(response.data);
            }
            return response.data;
          });
      },
      signOut: function () {
        return $http.delete('/api/logout.json')
          .then(function () {
            Session.signOut();
          });
      },
      check: function () {
        if (Session.isSignedIn()) {
          return $q.when();
        } else {
          return querySession();
        }
      }
    };

    scheduleSessionQuery();

    return service;
  });
