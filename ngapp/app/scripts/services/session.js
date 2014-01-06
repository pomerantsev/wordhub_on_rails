'use strict';

angular.module('wordhubApp')
  .factory('Session', function ($cookies, $rootScope, SETTINGS) {
    var sessionKey = SETTINGS.sessionCookie;
    var getCurrentUser = function () {
      return JSON.parse($cookies[sessionKey]);
    };
    var saveCurrentUser = function (user) {
      $cookies[sessionKey] = JSON.stringify(user);
    };
    $rootScope.$on('event:flashcardCreated', function () {
      var user = getCurrentUser();
      user.createdToday++;
      saveCurrentUser(user);
      $rootScope.$broadcast('event:userInfoChanged');
    });
    $rootScope.$on('event:repetitionRun', function () {
      var user = getCurrentUser();
      user.runToday++;
      saveCurrentUser(user);
      $rootScope.$broadcast('event:userInfoChanged');
    });
    return {
      signIn: function (user) {
        saveCurrentUser(user);
        $rootScope.$broadcast('event:signedIn');
      },
      currentUser: function () {
        if (this.isSignedIn()) {
          return getCurrentUser();
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
