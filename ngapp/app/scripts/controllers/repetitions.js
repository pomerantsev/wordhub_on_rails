'use strict';

angular.module('wordhubApp')
  .controller('RepetitionsCtrl', function (Repetition, $location, SETTINGS, Session, $scope) {
    var ctrl = this;

    var getRandom = function () {
      Repetition.getRandom()
        .then(function (repetition) {
          ctrl.currentRepetition = repetition;
          ctrl.currentText = repetition.flashcard.frontText;
        }, function () {
          $location.path(SETTINGS.defaultSignedInRoute);
        });
    };

    var update = function (successful) {
      ctrl.currentRepetition.successful = successful;
      ctrl.submitting = true;
      ctrl.currentRepetition.$patch()
        .then(function () {
          getRandom();
        }).finally(function () {
          ctrl.submitting = false;
        });
    };

    getRandom();

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

    var getProgressToday = function () {
      var currentUser = Session.currentUser();
      return currentUser.runToday / currentUser.plannedForToday;
    };

    ctrl.progressToday = getProgressToday();

    $scope.$watch(function () {
      return getProgressToday();
    }, function (progress) {
      ctrl.progressToday = progress;
    });
  });
