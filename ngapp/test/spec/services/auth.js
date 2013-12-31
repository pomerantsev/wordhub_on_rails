'use strict';

describe('Service: Auth', function () {

  // load the service's module
  beforeEach(module('wordhubApp'));

  // instantiate service
  var Auth, $httpBackend;
  beforeEach(inject(function (_Auth_, _$httpBackend_) {
    Auth = _Auth_;
    $httpBackend = _$httpBackend_;
  }));

  describe('#signIn', function () {
    var credentials = {email: 'fake@example.com', password: 'secret'};
    it('sends a POST request', function () {
      $httpBackend.expectPOST('/api/login.json').respond(200);
      Auth.signIn(credentials);
      $httpBackend.flush();
    });
  });

  describe('#signOut', function () {
    it('sends a DELETE request', function () {
      $httpBackend.expectDELETE('/api/logout.json').respond(204);
      Auth.signOut();
      $httpBackend.flush();
    });
  });

});
