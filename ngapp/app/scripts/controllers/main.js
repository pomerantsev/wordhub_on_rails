'use strict';

angular.module('wordhubApp')
  .controller('MainCtrl', function (Auth, $rootScope, $translate, SETTINGS) {
    var ctrl = this;
    ctrl.credentials = {};
    ctrl.signIn = function () {
      ctrl.submitting = true;
      Auth.signIn(ctrl.credentials)
        .then(function (data) {
          if (!data.success) {
            $rootScope.$broadcast(SETTINGS.customErrorEvent,
              $translate('flash.userNotRegistered'));
          }
        }).finally(function () {
          ctrl.submitting = false;
        });
    };
  });
