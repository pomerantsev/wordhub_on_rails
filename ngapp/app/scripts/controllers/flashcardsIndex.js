'use strict';

angular.module('wordhubApp')
  .controller('FlashcardsIndexCtrl', function ($http) {
    var ctrl = this;
    ctrl.flashcards = [];
    $http.get('/api/flashcards.json')
      .success(function (data) {
        ctrl.flashcards = data;
      });
  });
