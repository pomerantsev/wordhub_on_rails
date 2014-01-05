'use strict';

describe('Controller: EditFlashcardCtrl', function () {

  // load the controller's module
  beforeEach(module('wordhubApp'));

  var editFlashcardCtrl, $httpBackend, mockFlashcard, mockRouteParams,
      $location, flashcardId = 1;

  // Initialize the controller and a mock scope
  beforeEach(inject(function ($controller, _$httpBackend_, _$resource_, _$location_) {
    $httpBackend = _$httpBackend_;
    $location = _$location_;
    mockFlashcard = _$resource_('/api/flashcards/:id.json', {id: '@id'}, {
      patch: { method: 'PATCH' }
    });
    mockRouteParams = { id: flashcardId };
    $httpBackend.expectGET('/api/flashcards/' + flashcardId + '.json').respond(200, {
      id: flashcardId,
      frontText: 'front',
      backText: 'back'
    });
    editFlashcardCtrl = $controller('EditFlashcardCtrl', {
      Flashcard: mockFlashcard,
      $routeParams: mockRouteParams,
      $location: $location
    });
    $httpBackend.flush();
  }));

  describe('#update', function () {
    function sharedBehaviorForUpdate (status) {
      beforeEach(function () {
        $httpBackend.expectPATCH('/api/flashcards/' + flashcardId + '.json').respond(status);
        editFlashcardCtrl.update();
        $httpBackend.flush();
      });

      it('sets "submitting" to false after getting the response', function () {
        expect(editFlashcardCtrl.submitting).toBe(false);
      });
    }
    describe('when successful', function () {
      sharedBehaviorForUpdate(204);

      it('changes the location', function () {
        expect($location.path()).toBe('/flashcards');
        expect($location.hash()).toBe(flashcardId);
      });
    });
    describe('when unsuccessful', function () {
      sharedBehaviorForUpdate(422);
    });
  });

  describe('#delete', function () {
    beforeEach(function () {
      $httpBackend.expectDELETE('/api/flashcards/' + flashcardId + '.json').respond(204);
      editFlashcardCtrl.delete();
      $httpBackend.flush();
    });

    it('changes the location', function () {
      expect($location.path()).toBe('/flashcards');
    });
  });

});
