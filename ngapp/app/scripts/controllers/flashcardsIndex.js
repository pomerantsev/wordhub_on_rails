'use strict';

angular.module('wordhubApp')
  .controller('FlashcardsIndexCtrl', function ($http, SETTINGS) {
    var ctrl = this;
    ctrl.routes = SETTINGS.routes;
    ctrl.flashcards = [];
    $http.get('/api/flashcards.json')
      .success(function (data) {
        ctrl.flashcards = data;
      });
  });
