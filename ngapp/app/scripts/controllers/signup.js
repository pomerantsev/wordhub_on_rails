'use strict';

angular.module('wordhubApp')
  .controller('SignupCtrl', function (User, $translate, Page) {
    Page.setTitle($translate('users.new.newUser'));
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
