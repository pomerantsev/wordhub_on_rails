'use strict';

angular.module('wordhubApp')
  .controller('SignupCtrl', function (User) {
    var ctrl = this;
    ctrl.newUser = {};
    ctrl.signup = function () {
      User.save(ctrl.newUser);
    };
  });
