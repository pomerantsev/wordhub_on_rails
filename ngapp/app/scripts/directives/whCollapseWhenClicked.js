'use strict';

angular.module('wordhubApp')
  .directive('whCollapseWhenClicked', function () {
    return {
      restrict: 'A',
      link: function (scope, element) {
        element.on('click', function () {
          scope.toggleDropdown();
        });
      }
    };
  });