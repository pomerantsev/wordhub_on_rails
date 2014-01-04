'use strict';

describe('Controller: NewFlashcardCtrl', function () {

  // load the controller's module
  beforeEach(module('wordhubApp'));

  var newFlashcardCtrl, $httpBackend;

  // Initialize the controller and a mock scope
  beforeEach(inject(function ($controller, _$httpBackend_) {
    $httpBackend = _$httpBackend_;
    newFlashcardCtrl = $controller('NewFlashcardCtrl');
  }));

  describe('#create', function () {
    function sharedBehaviorForCreate (flashcard, status) {
      beforeEach(function () {
        $httpBackend.expectPOST('/api/flashcards.json').respond(status);
        newFlashcardCtrl.flashcard = flashcard;
        newFlashcardCtrl.create();
        $httpBackend.flush();
      });
    }
    describe('when successful', function () {
      var flashcard = {frontText: 'front', backText: 'back'};
      sharedBehaviorForCreate(flashcard, 201);

      it('empties the controller\'s flashcard object', function () {
        expect(newFlashcardCtrl.flashcard).toEqual({});
      });
    });
    describe('when unsuccessful', function () {
      var flashcard = {frontText: 'front', backText: ''};
      sharedBehaviorForCreate(flashcard, 422);

      it('doesn\'t empty the flashcard object', function () {
        expect(newFlashcardCtrl.flashcard).not.toEqual({});
      });
    });
  });

});
