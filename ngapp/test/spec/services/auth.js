'use strict';

describe('Service: Auth', function () {
  var Session;
  // load the service's module
  beforeEach(module('wordhubApp', function ($provide) {
    Session = jasmine.createSpyObj('Session', ['signIn', 'signOut']);
    $provide.value('Session', Session);
  }));

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
    it('doesn\'t call Session.signIn if response.data.success isn\'t true', function () {
      $httpBackend.expectPOST('/api/login.json')
        .respond(200, {success: false});
      Auth.signIn(credentials);
      $httpBackend.flush();
      expect(Session.signIn).not.toHaveBeenCalled();
    });
    it('calls Session.signIn if response.data.success is true', function () {
      $httpBackend.expectPOST('/api/login.json')
        .respond(200, {success: true});
      Auth.signIn(credentials);
      $httpBackend.flush();
      expect(Session.signIn).toHaveBeenCalled();
    });
    it('returns a promise', function () {
      expect(typeof Auth.signIn(credentials).then).toBe('function');
    });
  });

  describe('#signOut', function () {
    it('sends a DELETE request and calls Session.signOut', function () {
      $httpBackend.expectDELETE('/api/logout.json').respond(204);
      Auth.signOut();
      $httpBackend.flush();
      expect(Session.signOut).toHaveBeenCalled();
    });
    it('returns a promise', function () {
      expect(typeof Auth.signOut().then).toBe('function');
    });
  });

});
