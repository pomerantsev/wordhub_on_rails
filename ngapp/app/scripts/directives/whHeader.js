'use strict';

angular.module('wordhubApp')
  .directive('whHeader', function (Auth, Session) {
    return {
      restrict: 'E',
      replace: true,
      templateUrl: 'views/directives/whHeader.html',
      link: function (scope) {
        var updateMenu = function () {
          scope.isSignedIn = Session.isSignedIn();
        };
        updateMenu();
        scope.$on('event:signedIn', updateMenu);
        scope.$on('event:signedOut', updateMenu);
        scope.signOut = function () {
          Auth.signOut();
        };
      }
    };
  });
