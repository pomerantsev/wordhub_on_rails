'use strict';

angular.module('wordhubApp')
  .controller('RepetitionsCtrl', function (Repetition, $location, SETTINGS) {
    var ctrl = this;

    var query = function () {
      ctrl.repetitions = Repetition.query();
      ctrl.repetitions.$promise
        .then(function() {
          if (ctrl.repetitions.length === 0) {
            $location.path(SETTINGS.defaultSignedInRoute);
          } else {
            ctrl.currentRepetition =
              ctrl.repetitions[Math.floor(Math.random() * ctrl.repetitions.length)];
            ctrl.currentText = ctrl.currentRepetition.flashcard.frontText;
          }
        });
    };

    var update = function (successful) {
      ctrl.currentRepetition.successful = successful;
      ctrl.submitting = true;
      ctrl.currentRepetition.$patch()
        .then(function () {
          query();
        }).finally(function () {
          ctrl.submitting = false;
        });
    };

    query();

    ctrl.turnAround = function () {
      var flashcard = ctrl.currentRepetition.flashcard;
      ctrl.currentText =
        ctrl.currentText === flashcard.frontText ?
        flashcard.backText : flashcard.frontText;
    };

    ctrl.dontRemember = function () {
      update(false);
    };
    ctrl.remember = function () {
      update(true);
    };
  });
