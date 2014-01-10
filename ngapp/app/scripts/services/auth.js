'use strict';

angular.module('wordhubApp')
  .factory('Auth', function ($http, Session, RepetitionStore, $q, $rootScope) {
    var performSignIn = function (data) {
      Session.signIn(data.user);
      RepetitionStore.saveAll(data.repetitions);
    };

    return {
      signIn: function (credentials) {
        return $http.post('/api/login.json',
          {email: credentials.email, password: credentials.password})
          .then(function (response) {
            if (response.data && response.data.success) {
              performSignIn(response.data);
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
          var defer = $q.defer();
          defer.resolve();
          return defer.promise;
        } else {
          return $http.get('/api/session.json')
            .then(function (response) {
              if (response.data && response.data.success) {
                performSignIn(response.data);
                return response;
              } else {
                Session.signOut();
                return $q.reject();
              }
            });
        }
      }
    };
  });
