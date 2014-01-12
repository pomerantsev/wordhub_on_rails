'use strict';

angular.module('wordhubApp')
  .controller('SignupCtrl', function (User) {
    var ctrl = this;
    ctrl.newUser = {};
    ctrl.signup = function () {
      ctrl.submitting = true;
      User.save(ctrl.newUser).$promise
        .finally(function () {
          ctrl.submitting = false;
        });
    };
  });
