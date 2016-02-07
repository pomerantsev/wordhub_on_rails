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

  COLUMNS_KEY = 'wordhub_columns'

  updateFlashcardsDisplay = (isColumns) ->
    $checkbox = $('.js-flashcards-columns-checkbox')
    $checkbox.prop('checked', isColumns)

    localStorage.setItem COLUMNS_KEY, if isColumns then 'true' else 'false'

    if isColumns
      $('.js-flashcard')
        .addClass('flashcard-columns')
        .removeClass('flashcard-rows')
    else
      $('.js-flashcard')
        .addClass('flashcard-rows')
        .removeClass('flashcard-columns')

  updateFlashcardsDisplay(if localStorage.getItem(COLUMNS_KEY) is 'true' then true else false)

  $('.js-flashcards-columns-checkbox').on 'change', (event) ->
    updateFlashcardsDisplay(event.target.checked)
