$ ->
  return unless $('body.reports_controller.dashboard_action').length

  json  = $('.stats .csv').data('json')
  csv   = JSON.parse(json)
  graph = $('.stats .graph')
  graph = new Dygraph(graph[0], csv)
