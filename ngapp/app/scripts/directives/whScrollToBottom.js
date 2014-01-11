'use strict';

angular.module('wordhubApp')
  .directive('whScrollToBottom', function ($window) {
    return {
      restrict: 'A',
      scope: {
        whScrollToBottom: '&'
      },
      link: function (scope, element, attrs) {
        var windowElement = angular.element($window);
        var bodyElement = angular.element(document).find('body')[0];
        var bodyBottom, elementBottom;
        windowElement.on('scroll', function () {
          bodyBottom = bodyElement.scrollTop + $window.innerHeight;
          elementBottom = element.prop('offsetTop') + element.prop('offsetHeight');
          // Somehow the directive is linked to two elements initially;
          // one has a height of 0. Should do this check anyway to avoid
          // querying next batch when the previous batch's promise
          // hasn't resolved.
          if (element.prop('offsetHeight') > 0 && bodyBottom >= elementBottom) {
            windowElement.off('scroll');
            scope.whScrollToBottom();
          }
        });
      }
    };
  });
