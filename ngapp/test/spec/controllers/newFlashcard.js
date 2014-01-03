'use strict';

describe('Controller: NewflashcardCtrl', function () {

  // load the controller's module
  beforeEach(module('wordhubApp'));

  var NewflashcardCtrl,
    scope;

  // Initialize the controller and a mock scope
  beforeEach(inject(function ($controller, $rootScope) {
    scope = $rootScope.$new();
    NewflashcardCtrl = $controller('NewflashcardCtrl', {
      $scope: scope
    });
  }));

});
