'use strict';

angular.module('wordhubApp')
  .controller('RepetitionsCtrl', function (Repetition) {
    var ctrl = this;
    ctrl.repetitions = Repetition.query();
  });
