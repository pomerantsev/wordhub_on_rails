'use strict';

angular.module('wordhubApp')
  .controller('StatsCtrl', function (Session, $translate, Page) {
    Page.setTitle($translate('nav.stats'));

    var transformStats = function (stats) {
      stats.totalStats.plannedRepetitionsForNearestDate +=
        ' (' + stats.totalStats.nearestDate + ')';
      delete stats.totalStats.nearestDate;
      stats.statsForMonth.successfulRepetitions +=
        ' (' + stats.statsForMonth.successfulRepetitionsPercentage + '%)';
      delete stats.statsForMonth.successfulRepetitionsPercentage;
      stats.statsForToday.successfulRepetitions +=
        ' (' + stats.statsForToday.successfulRepetitionsPercentage + '%)';
      delete stats.statsForToday.successfulRepetitionsPercentage;
    };

    this.stats = Session.stats();
    transformStats(this.stats);
  });
