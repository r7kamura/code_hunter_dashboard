$ ->
  return unless $('body.reports_controller.dashboard_action').length
  $('.chart').each ->
    chart = $(this)
    graph = chart.find('.graph')
    json  = chart.find('.csv').data('json')
    csv   = JSON.parse(json)
    new Dygraph(graph[0], csv)


$ ->
  return unless $('body.reports_controller.show_action').length
  $('.warnings').each ->
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
