'use strict';

angular.module('wordhubApp')
  .factory('ViewHelpers', function (SETTINGS) {
    return {
      getCopyrightYears: function (currentYear) {
        var initialYear = SETTINGS.initialYear;
        if (initialYear === currentYear) {
          return initialYear;
        } else {
          return initialYear + '—' + currentYear;
        }
      }
    };
  });
