'use strict';

angular.module('wordhubApp')
  .directive('whHeader', function (Auth, Session) {
    return {
      restrict: 'E',
      replace: true,
      templateUrl: 'views/directives/whHeader.html',
      link: function (scope) {
        var updateSignedInStatus = function () {
          scope.isSignedIn = Session.isSignedIn();
        };
        updateSignedInStatus();
        scope.$on('event:signedIn', updateSignedInStatus);
        scope.$on('event:signedOut', updateSignedInStatus);
        scope.signOut = function () {
          Auth.signOut();
        };
      }
    };
  });
