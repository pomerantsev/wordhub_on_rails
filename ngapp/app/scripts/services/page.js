'use strict';

angular.module('wordhubApp')
  .service('Page', function (ViewHelpers) {
    var title = 'Hello';
    return {
      title: function () {
        return ViewHelpers.fullTitle(title);
      },
      setTitle: function (newTitle) {
        title = newTitle;
      }
    };
  });
