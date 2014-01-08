'use strict';

angular.module('wordhubApp')
  .factory('Auth', function ($http, Session, $q, $rootScope) {
    return {
      signIn: function (credentials) {
        return $http.post('/api/login.json',
          {email: credentials.email, password: credentials.password})
          .then(function (response) {
            if (response.data && response.data.success) {
              Session.signIn(response.data.user);
              $rootScope.$broadcast('event:signedIn');
            }
            return response.data;
          });
      },
      signOut: function () {
        return $http.delete('/api/logout.json')
          .then(function () {
            Session.signOut();
            $rootScope.$broadcast('event:signedOut');
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
                Session.signIn(response.data.user);
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
