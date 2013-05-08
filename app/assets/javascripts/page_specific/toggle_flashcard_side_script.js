$(function() {
	$(".flashcard-repeat, .flashcard-hidden").click(function(event) {
	   var invisibleSide = $(".flashcard-hidden");
	   $(event.currentTarget).removeClass("flashcard-repeat")
	   						 .addClass("flashcard-hidden");
	   invisibleSide.removeClass("flashcard-hidden")
	   				.addClass("flashcard-repeat");
	   return false;
	});
});