'use strict';

angular.module('wordhubApp')
  .controller('FlashcardsIndexCtrl', function (Flashcard, SETTINGS) {
    var ctrl = this;
    ctrl.routes = SETTINGS.routes;
    ctrl.flashcards = Flashcard.query();
  });
