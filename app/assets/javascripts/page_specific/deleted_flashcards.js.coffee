$ ->
  deletedTodayFull = $ '.js-deleted-today-full'
  deletedTodayFull.hide()

  btnUndelete = $ '.js-btn-undelete'
  btnUndelete.attr 'disabled', true

  $('.js-deleted-today-oneline').show()
  $('.js-deleted-today-oneline a').click ->
    $(@).hide()
    deletedTodayFull.show()

  $('.js-deleted-today-oneline a.js-just-deleted').animate
    backgroundColor: 'white'
    color: 'gray'
    1000

  $('.js-checkbox-undelete').click ->
    if $('.js-checkbox-undelete:checked').length > 0
      btnUndelete.attr('disabled', false)
    else
      btnUndelete.attr('disabled', true)
