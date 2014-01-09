'use strict';

angular.module('wordhubApp')
  .directive('whHeader', function (Auth, Session, $location, SETTINGS) {
    return {
      restrict: 'E',
      replace: true,
      templateUrl: 'views/directives/whHeader.html',
      link: function (scope) {
        scope.status = scope.status || {};
        scope.status.collapsingMenuCollapsed = true;
        scope.$watch(function () {
          return Session.currentUser();
        }, function (currentUser) {
          scope.isSignedIn = Session.isSignedIn();
          scope.currentUser = Session.currentUser();
        });
        scope.routes = SETTINGS.routes;
        scope.pathIs = function (path) {
          return $location.path() === path;
        };
        scope.signOut = function () {
          Auth.signOut();
        };
      }
    };
  });
