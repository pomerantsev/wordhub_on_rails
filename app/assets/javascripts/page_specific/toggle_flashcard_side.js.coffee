$ ->
  $('.flashcard-toggleable .flashcard, .flashcard-toggleable .hidden').click (event) ->
    visibleSide = $(event.currentTarget)
    invisibleSide = $('.hidden')
    visibleSide.
      removeClass('flashcard').
      addClass('hidden')
    invisibleSide.
      removeClass('hidden').
      addClass('flashcard')
    false
