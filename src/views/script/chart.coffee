API_KEY = 'AFArTyRIont4fZLaVXQVgY2kPv8EeIj4BwD24S3R'
endpoint = 'https://api.fda.gov/drug/event.json?api_key=' + API_KEY + '&'
dateFormat = d3.time.format('%Y%m%d')
dates = []


getDateCounts = ->
  query = endpoint + 'count=receivedate'
  d3.json query, (error, data) ->
    if error 
      return alert(error)
    dates = data.results
    dates.forEach (d) ->
      d.dd = dateFormat.parse(d.time)
      return
    alert JSON.stringify(dates)
    return
  return

drawChart = ->
  ndx = crossfilter(dates)
  xDimension = ndx.dimension((d) ->
    d.dd
  )
  newgroup = xDimension.group().reduceSum((d) ->
    d.count
  )
  yGroup = xDimension.group().reduceSum((d) -> 
  	d.time
  )
  dc.lineChart('#chart')
  .width(1000)
  .height(480)
  .x(d3.time.scale().domain([new Date(1995, 0, 1),new Date(2016, 11, 31)]))
  .elasticY(true)
  .mouseZoomable(true)
  .renderHorizontalGridLines(true)
  .renderArea(true)
  .brushOn(false)
  .dimension(xDimension)
  .group(newgroup)
  
  dc.renderAll()
  return

getDateCounts()
drawChart()