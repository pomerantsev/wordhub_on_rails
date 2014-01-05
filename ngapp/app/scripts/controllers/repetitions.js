'use strict';

angular.module('wordhubApp')
  .controller('RepetitionsCtrl', function (Repetition, $location, SETTINGS) {
    var ctrl = this;
    ctrl.repetitions = Repetition.query();
    ctrl.repetitions.$promise
      .then(function() {
        if (ctrl.repetitions.length === 0) {
          $location.path(SETTINGS.defaultSignedInRoute);
        } else {
          ctrl.currentRepetition = ctrl.repetitions[0];
          ctrl.currentText = ctrl.currentRepetition.flashcard.frontText;
        }
      });
  });
