'use strict';

angular.module('wordhubApp')
  .controller('MainCtrl', function (Auth, $rootScope, $translate, SETTINGS) {
    this.credentials = {};
    this.signIn = function () {
      Auth.signIn(this.credentials)
        .then(function (data) {
          if (!data.success) {
            $rootScope.$broadcast(SETTINGS.customErrorEvent,
              $translate('flash.userNotRegistered'));
          }
        });
    };
  });
