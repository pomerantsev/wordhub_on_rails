'use strict';

angular.module('wordhubApp')
  .factory('ViewHelpers', function (SETTINGS, $translate) {
    return {
      getCopyrightYears: function (currentYear) {
        var initialYear = SETTINGS.initialYear;
        if (initialYear === currentYear) {
          return initialYear;
        } else {
          return initialYear + '—' + currentYear;
        }
      },
      firstLine: function (text) {
        return text.replace(/$(.|[\r\n])+/m, '...');
      },
      fullTitle: function (title) {
        var baseTitle = $translate('nav.wordhub');
        if (title) {
          return title + ' — ' + baseTitle;
        } else {
          return baseTitle;
        }
      }
    };
  });
