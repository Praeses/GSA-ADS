dateFormat = d3.time.format('%Y%m%d')


class DrugChart

  constructor: (@args = {}) ->
    @args.url= "/drug_counts.csv"
    @getData(@args.url)


  getData: (url) =>
    d3.csv url, @onData


  onData: (error, data) =>
    @min_date = dateFormat.parse(data[0].date)
    @max_date = dateFormat.parse(data[data.length - 1].date)
    data.forEach (d) ->
      d.dd = dateFormat.parse(d.date)
    @ndx = crossfilter(data)
    #graph the drug if one has been picked
    @graphDrug(@drug) if @drug


  graphDrug: (drug) =>
    @drug = drug
    #deplay the graphing unless the data is ready
    return unless @ndx
    @dimension = @ndx.dimension((d) -> d.dd )
    @group = @dimension.group().reduceSum( (d) => d[@drug] )
    @drawChart()


  drawChart: () =>
    dc.lineChart('#chart')
      .width(1000)
      .height(500)
      .x(d3.time.scale().domain([@min_date,@max_date]))
      #.x(d3.time.scale().domain([new Date(1999, 0, 1),new Date(2015, 11, 31)]))
      .y(d3.scale.linear().domain([0, 10000]))
      .elasticY(true)
      .mouseZoomable(true)
      .renderHorizontalGridLines(true)
      .renderArea(true)
      .brushOn(false)
      .dimension(@dimension)
      .group(@group)
      .yAxisLabel(@drug + " Count")
      .xAxisLabel("Date Received")
      .render()




chart = new DrugChart()
chart.graphDrug("sodium")

