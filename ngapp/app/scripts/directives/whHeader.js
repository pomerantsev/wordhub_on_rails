'use strict';

app.directive('whHeader', function () {
  return {
    restrict: 'E',
    replace: true,
    templateUrl: 'views/directives/whHeader.html'
  };
});
