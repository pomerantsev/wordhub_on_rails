'use strict';

angular.module('wordhubApp')
  .controller('FlashcardsIndexCtrl', function (Flashcard, SETTINGS, $routeParams, $location) {
    var ctrl = this;
    var queryFlashcards = function () {
      ctrl.flashcards = Flashcard.query({search: ctrl.searchString});
    };
    ctrl.routes = SETTINGS.routes;
    ctrl.submittedSearchString = ctrl.searchString = $routeParams.search;
    queryFlashcards();

    ctrl.search = function () {
      ctrl.submittedSearchString = ctrl.searchString;
      $location.search({search: ctrl.searchString});
      queryFlashcards();
    };

    ctrl.clearSearch = function () {
      ctrl.submittedSearchString = ctrl.searchString = null;
      $location.search({});
      queryFlashcards();
    };

  });
