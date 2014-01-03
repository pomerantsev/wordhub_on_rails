'use strict';

angular.module('wordhubApp')
  .directive('whHeader', function (Auth, Session, $location, SETTINGS) {
    return {
      restrict: 'E',
      replace: true,
      templateUrl: 'views/directives/whHeader.html',
      link: function (scope) {
        var updateSignedInStatus = function () {
          scope.isSignedIn = Session.isSignedIn();
          if (scope.isSignedIn) {
            scope.currentUser = Session.currentUser();
          }
        };
        updateSignedInStatus();
        scope.$on('event:signedIn', updateSignedInStatus);
        scope.$on('event:signedOut', updateSignedInStatus);
        scope.routes = SETTINGS.routes;
        scope.pathIsNewFlashcard = function () {
          return $location.path() === SETTINGS.routes.newFlashcardPath;
        };
        scope.pathIsFlashcards = function () {
          return $location.path() === SETTINGS.routes.flashcardsPath;
        };
        scope.signOut = function () {
          Auth.signOut();
        };
      }
    };
  });
