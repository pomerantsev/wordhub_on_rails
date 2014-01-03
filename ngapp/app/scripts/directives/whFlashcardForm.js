'use strict';

angular.module('wordhubApp')
  .directive('whFlashcardForm', function () {
    return {
      restrict: 'E',
      templateUrl: 'views/directives/whFlashcardForm.html',
      replace: true,
      scope: {
        flObject: '=',
        flSubmitText: '@',
        flSubmitClass: '@',
        flSubmit: '&'
      }
    };
  });
