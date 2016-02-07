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

  $(document).on 'keydown', (event) ->
    if (event.shiftKey and
        not event.ctrlKey and
        not event.altKey and
        not event.metaKey)
      switch event.which
        when 37 then $('.js-dont-remember').submit()
        when 39 then $('.js-remember').submit()
