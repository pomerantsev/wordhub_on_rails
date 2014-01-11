node(:total) { @total }
node(:batchSize) { @batch_size }
child(@flashcards, object_root: false) { extends 'flashcards/flashcard' }
