'use strict';

angular.module('wordhubApp')
  .directive('whErrors', function (SETTINGS) {
    return {
      templateUrl: 'views/directives/whErrors.html',
      restrict: 'E',
      link: function postLink(scope) {
        var deleteMessage = function () { scope.errorMessage = ''; };
        scope.$on(SETTINGS.customErrorEvent, function (event, errorMessage) {
          scope.errorMessage = errorMessage;
        });
        scope.$on('$routeChangeStart', deleteMessage);
      }
    };
  });
