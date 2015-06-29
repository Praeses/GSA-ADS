dateFormat = d3.time.format('%Y%m%d')

class LocationCountChart

  constructor: (@args = {}) ->
    @args.el = "locationCountChart" unless @args.el
    @args.el = document.getElementById(@args.el)
    @chart = dc.rowChart("#" + @args.el.id)
    @args.url= "/location_counts.csv"
    @width = @args.el.parentNode.offsetWidth


  loadingDiv: (visible) =>
    if visible
      @args.el.className += " whirl loadChart"
    else
      @args.el.className = @args.el.className.replace(" whirl loadChart","")
    visible


  loadChart: () =>
    @loadingDiv(true)
    setTimeout @getData, 0


  getData: () =>
    d3.csv @args.url, @onData


  onData: (error, data) =>
    @ndx = crossfilter(data)
    @drawChart()

  drawChart: () =>
    dim = @ndx.dimension( (d) -> d["LOCATION"] )
    group = dim.group().reduceSum( (d) -> parseInt(d[" COUNT"]) )
    @chart
      .width(@width)
      .dimension(dim)
      .group(group)
      .cap(6)

    @chart.onClick = () ->
    @chart.render()

    @loadingDiv(false)



global_namespace = global if global?
global_namespace = window if window?
global_namespace.App = {} unless global_namespace.App
global_namespace.App.LocationCountChart = LocationCountChart

