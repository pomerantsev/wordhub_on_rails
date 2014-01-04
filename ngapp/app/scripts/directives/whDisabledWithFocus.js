'use strict';

// Duplicating ng-disabled functionality here
// and adding focusing after the element is enabled.
angular.module('wordhubApp')
  .directive('whDisabledWithFocus', function () {
    return {
      scope: {
        whDisabledWithFocus: "="
      },
      link: function (scope, element, attrs) {
        scope.$watch('whDisabledWithFocus', function (value) {
          attrs.$set('disabled', !!value);
          if (!value) {
            element[0].focus();
          }
        });
      }
    };
  });
