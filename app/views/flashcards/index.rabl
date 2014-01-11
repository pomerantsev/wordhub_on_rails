node(:total) { @total }
node(:batchSize) { @batch_size }
child(@flashcards, object_root: false) { extends 'flashcards/flashcard' }
child({@deleted_flashcards => :deletedFlashcards}, object_root: false) do
  extends 'flashcards/flashcard'
end
