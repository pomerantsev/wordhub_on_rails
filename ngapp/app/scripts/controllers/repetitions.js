'use strict';

angular.module('wordhubApp')
  .controller('RepetitionsCtrl', function (Repetition, $location, SETTINGS, Session, $scope, $translate, Page) {
    Page.setTitle($translate('repetitions.index.title'));
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
      Repetition.update(ctrl.currentRepetition);
      getRandom();
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
