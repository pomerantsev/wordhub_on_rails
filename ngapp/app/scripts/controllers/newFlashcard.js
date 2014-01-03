'use strict';

angular.module('wordhubApp')
  .controller('NewFlashcardCtrl', function (Flashcard, SETTINGS, $rootScope) {
    var ctrl = this;
    ctrl.flashcard = {};
    ctrl.create = function () {
      Flashcard.save(ctrl.flashcard).$promise
        .then(function () {
          ctrl.flashcard = {};
        }, function (reason) {
          $rootScope.$broadcast(SETTINGS.customErrorEvent, reason.data);
        });
    };
  });
