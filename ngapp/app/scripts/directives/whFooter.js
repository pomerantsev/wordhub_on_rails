'use strict';

angular.module('wordhubApp')
  .directive('whFooter', function (ViewHelpers) {
    return {
      restrict: 'E',
      replace: true,
      templateUrl: 'views/directives/whFooter.html',
      link: function (scope) {
        scope.copyrightYears = ViewHelpers.getCopyrightYears(new Date().getFullYear());
      }
    };
  });
