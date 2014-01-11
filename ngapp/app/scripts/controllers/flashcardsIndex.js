'use strict';

angular.module('wordhubApp')
  .controller('FlashcardsIndexCtrl', function (Flashcard, SETTINGS, $routeParams, $location) {
    var ctrl = this;
    var queryFlashcards = function () {
      ctrl.flashcards = Flashcard.query({search: ctrl.searchString});
    };
    ctrl.routes = SETTINGS.routes;
    ctrl.searchString = $routeParams.search;
    queryFlashcards();

    ctrl.search = function () {
      $location.search({search: ctrl.searchString});
      queryFlashcards();
    };
  });
