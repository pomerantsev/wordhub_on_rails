'use strict';

angular.module('wordhubApp')
  .controller('NewFlashcardCtrl', function (Flashcard) {
    this.flashcard = {};
    this.create = function () {
      Flashcard.save({flashcard: this.flashcard});
    };
  });
