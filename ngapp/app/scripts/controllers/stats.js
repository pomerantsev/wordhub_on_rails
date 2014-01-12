'use strict';

angular.module('wordhubApp')
  .controller('StatsCtrl', function (Session) {
    this.stats = Session.stats();
  });
