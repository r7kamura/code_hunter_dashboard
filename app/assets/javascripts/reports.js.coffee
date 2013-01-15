$ ->
  return unless $('body.reports_controller').length
  $('.chart').each ->
    chart = $(this)
    graph = chart.find('.graph')
    json  = chart.find('.csv').data('json')
    roll  = graph.data('roll')
    csv   = JSON.parse(json)
    new Dygraph(graph[0], csv, rollPeriod: roll)
