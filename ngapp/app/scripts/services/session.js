'use strict';

angular.module('wordhubApp')
  .factory('Session', function ($rootScope, RepetitionStore) {
    var _currentUser;
    var getCurrentUser = function () {
      return _currentUser;
    };
    var saveCurrentUser = function (user) {
      _currentUser = user;
    };
    var deleteCurrentUser = function () {
      _currentUser = null;
    };
    // TODO: probably better to $watch something than to listen to events.
    $rootScope.$on('event:flashcardCreated', function () {
      var user = getCurrentUser();
      user.createdToday++;
      saveCurrentUser(user);
    });
    $rootScope.$watch(function () {
      return RepetitionStore.getLength();
    }, function (repetitionsLeft) {
      _currentUser.runToday = _currentUser.plannedForToday - repetitionsLeft;
    });
    return {
      signIn: function (user) {
        saveCurrentUser(user);
      },
      currentUser: function () {
        return getCurrentUser();
      },
      isSignedIn: function () {
        return !!getCurrentUser();
      },
      signOut: function () {
        deleteCurrentUser();
      }
    };
  });
