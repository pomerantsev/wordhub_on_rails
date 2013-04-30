$(".flashcard, .flashcard-hidden").click(function(event) {
   var invisibleSide = $(".flashcard-hidden");
   $(event.currentTarget).removeClass("flashcard").addClass("flashcard-hidden");
   invisibleSide.removeClass("flashcard-hidden").addClass("flashcard");
   return false;
});
