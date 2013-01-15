$ ->
  return unless $('body.reports_controller.dashboard_action').length
  $('.chart').each ->
    chart = $(this)
    graph = chart.find('.graph')
    json  = chart.find('.csv').data('json')
    csv   = JSON.parse(json)
    new Dygraph(graph[0], csv)
