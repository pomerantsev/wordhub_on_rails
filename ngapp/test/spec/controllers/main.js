'use strict';

describe('Controller: MainCtrl', function () {

  // load the controller's module
  beforeEach(module('wordhubApp'));

  var MainCtrl,
    scope;

  // Initialize the controller and a mock scope
  beforeEach(inject(function ($controller, $rootScope, _Auth_) {
    scope = $rootScope.$new();
    MainCtrl = $controller('MainCtrl', {
      Auth: _Auth_
    });
  }));

  it('instantiates with empty credentials', function () {
    expect(MainCtrl.credentials).toEqual({});
  });

  describe('#signIn', function () {
    it('calls Auth\'s signIn method', function () {
      // TODO: implement later. How to verify that a method has been called?
    });
  });

});
