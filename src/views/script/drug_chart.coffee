dateFormat = d3.time.format('%Y%m%d')

class DrugChart

  constructor: (@args = {}) ->
    @compositeChart = dc.compositeChart('#compositeChart')
    @dimIndex = 2
    @args.url= "/drug_events_by_date.csv"
    @width = document.getElementById("compositeChart").parentNode.offsetWidth - 50

  loadingDiv: (visible) =>
    element = document.getElementById("compositeChart")
    if visible
      element.className += " whirl loadChart"
    else
      element.className = element.className.replace(" whirl loadChart","")
    return

  capitalize: (s) =>
    return s.charAt(0).toUpperCase()+s.slice(1)

  getRandomNumber: (max,min=0) =>
    return Math.floor(Math.random()*(max-min)+min)

  getRandomColor: =>
    return d3.rgb(@getRandomNumber(255),@getRandomNumber(255),@getRandomNumber(255)).toString()

  getDrugList: (object) =>
    list = []
    keys = Object.keys object
    keys.forEach (k) ->
      if k == 'date' or k == 'dd' or k == 'dm' or k == 'dy' then return
      list.push k
      return
    return list

  loadChart: () =>
    @getData(@args.url)

  getData: (url) =>
    d3.csv url, @onData

  onData: (error, data) =>
    @min_date = dateFormat.parse(data[0].date)
    @max_date = dateFormat.parse(data[data.length - 1].date)
    data.forEach (d) ->
      d.dd = dateFormat.parse(d.date)
      d.dm = dateFormat.parse(d.date).setDate(1)
      d.dy = dateFormat.parse(d.date).setMonth(1,1)
    @ndx = crossfilter(data)
    @drugList = @getDrugList data[0]
    @drawChart()

  getDimension: () =>
    if @dimIndex == 1
      return @ndx.dimension((d) -> d.dd)
    else if @dimIndex == 2
      return @ndx.dimension((d) -> d.dm)
    else if @dimIndex == 3
      return @ndx.dimension((d) -> d.dy)
    else
      @dimIndex = 2
      return @ndx.dimension((d) -> d.dm)

  getCharts: () =>
    group = []
    @drugList.forEach (item) =>
      group.push dc.lineChart(@compositeChart).group(@getDimension().group().reduceSum((d) => d[item]), @capitalize(item)).colors([@getRandomColor()])
      return
    return group

  drawChart: () =>
    @compositeChart
      .width(@width)
      .height(500)
      .margins({top:10,right:10,bottom:40,left:40})
      .x(d3.time.scale().domain([@min_date,@max_date]))
      .y(d3.scale.linear().domain([0, 10000]))
      .elasticY(true)
      .mouseZoomable(true)
      .legend(dc.legend().x(70).y(10))
      .renderHorizontalGridLines(true)
      .brushOn(false)
      .dimension(@getDimension())
      .yAxisLabel("Event Count")
      .xAxisLabel("Date Received")
      .compose(@getCharts())
      .render()
    @loadingDiv(false)

  changeResolution: (num) =>
    @dimIndex = num
    @loadingDiv(true)
    setTimeout @drawChart, 1
    return

window.chart = new DrugChart()
chart.loadChart()

