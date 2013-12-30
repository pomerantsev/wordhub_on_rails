'use strict';

angular.module('wordhubApp')
  .factory('Session', function ($cookies, $rootScope) {
    var sessionKey = 'wordhubAngularSession';
    return {
      signIn: function (user) {
        $cookies[sessionKey] = JSON.stringify(user);
        $rootScope.$broadcast('event:signedIn');
      },
      currentUser: function () {
        if (this.isSignedIn()) {
          return JSON.parse($cookies[sessionKey]);
        } else {
          return null;
        }
      },
      isSignedIn: function () {
        return !!$cookies[sessionKey];
      },
      signOut: function () {
        delete $cookies[sessionKey];
        $rootScope.$broadcast('event:signedOut');
      }
    };
  });
