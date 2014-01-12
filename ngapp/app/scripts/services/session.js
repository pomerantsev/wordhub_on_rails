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
    $rootScope.$watch(function () {
      return RepetitionStore.getLength();
    }, function (repetitionsLeft) {
      if (_currentUser) {
        _currentUser.runToday = _currentUser.plannedForToday - repetitionsLeft;
      }
    });
    return {
      signIn: function (data) {
        saveCurrentUser(data.user);
        RepetitionStore.saveAll(data.repetitions);
      },
      currentUser: function () {
        return getCurrentUser();
      },
      isSignedIn: function () {
        return !!getCurrentUser();
      },
      signOut: function () {
        deleteCurrentUser();
      },
      changeCreatedTodayBy: function (amount) {
        if (_currentUser) {
          _currentUser.createdToday += amount;
        }
      }
    };
  });
