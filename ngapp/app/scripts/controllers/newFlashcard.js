'use strict';

angular.module('wordhubApp')
  .controller('NewFlashcardCtrl', function (Flashcard) {
    var ctrl = this;
    ctrl.flashcard = {};
    ctrl.create = function () {
      ctrl.submitting = true;
      Flashcard.save(ctrl.flashcard).$promise
        .then(function () {
          ctrl.flashcard = {};
        })
        .finally(function () {
          ctrl.submitting = false;
        });
    };
  });
