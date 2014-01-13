'use strict';

angular.module('wordhubApp')
  .service('Page', function (ViewHelpers) {
    var title = '';
    return {
      title: function () {
        return ViewHelpers.fullTitle(title);
      },
      setTitle: function (newTitle) {
        title = newTitle;
      }
    };
  });
