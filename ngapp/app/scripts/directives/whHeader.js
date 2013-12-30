'use strict';

window.app.directive('whHeader', function (Auth, Session) {
  return {
    restrict: 'E',
    replace: true,
    templateUrl: 'views/directives/whHeader.html',
    link: function (scope) {
      scope.isSignedIn = Session.isSignedIn();
      scope.$on('event:signedIn', function () {
        scope.isSignedIn = Session.isSignedIn();
      });
      scope.signOut = function () {
        Auth.signOut();
      };
    }
  };
});
