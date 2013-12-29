'use strict';

window.app.factory('Session', function ($cookies) {
  var sessionKey = 'wordhubAngularSession';
  return {
    signIn: function (user) {
      $cookies[sessionKey] = JSON.stringify(user);
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
    }
  };
});
