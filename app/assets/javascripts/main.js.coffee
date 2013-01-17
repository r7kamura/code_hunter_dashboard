$ ->
  $('header .links a').tooltip()

  $('.tabbed_warnings').each ->
    container = $(this)
    warnings  = container.find('tbody tr')
    tabs      = container.find('li')
    tabs.click (e) ->
      tab = $(this)
      e.preventDefault()
      tabs.removeClass('active')
      tab.addClass('active')
      className = tab.text()
      warnings.each ->
        warning = $(this)
        warning.toggle(warning.hasClass(className))
