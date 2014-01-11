'use strict';

angular.module('wordhubApp')
  .controller('FlashcardsIndexCtrl', function (Flashcard, SETTINGS, $routeParams, $location) {
    var ctrl = this;
    var totalFlashcards, batchSize;
    var anyFlashcardsLeft = function () {
      // It's not strictly correct since new flashcards could be created
      // in another browser window. This issue is to be addressed later.
      return ctrl.batches.length * batchSize < totalFlashcards;
    };
    ctrl.batches = [];
    var queryFlashcards = function (page) {
      page = page || 1;
      ctrl.batches.length = page;
      Flashcard.query({
        search: ctrl.searchString,
        page: page
      }).$promise.then(function (data) {
        ctrl.batches[page-1] = data.flashcards;
        totalFlashcards = data.total;
        batchSize = data.batchSize;
      });
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

    ctrl.queryNextBatch = function () {
      if (anyFlashcardsLeft()) {
        queryFlashcards(ctrl.batches.length + 1);
      }
    };

  });
