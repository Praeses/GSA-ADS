
ChartLib = {}


ChartLib.capitalize = (s) ->
  s.charAt(0).toUpperCase()+s.slice(1)

ChartLib.getRandom = (max,min=0) =>
  return Math.floor(Math.random()*(max-min)+min)

ChartLib.findKeys = (object, ignore) =>
	list = []
	keys = Object.keys object
	keys.forEach (k) ->
	  if ignore.indexOf(k) > -1
	    return
	  list.push k
	  return
	return list

ChartLib.getTime = (timestamp) =>
  d = new Date(timestamp)
  months = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec']
  year = d.getFullYear()
  month = months[d.getMonth()]
  date = d.getDate()
  return month+' '+date+', '+year

ChartLib.formatAxis = (value) =>
  newValue = value
  if value >= 1000
    suffixes = [ 
      ''
      'K'
      'M'
      'B'
      'T'
    ]
    suffixNum = Math.floor(('' + value).length / 3)
    shortValue = ''
    precision = 2
    while precision >= 1
      shortValue = parseFloat((if suffixNum != 0 then value / 1000 ** suffixNum else value).toPrecision(precision))
      dotLessShortValue = (shortValue + '').replace(/[^a-zA-Z 0-9]+/g, '')
      if dotLessShortValue.length <= 2
        break
      precision--
    if shortValue % 1 != 0
      shortNum = shortValue.toFixed(1)
    newValue = shortValue + suffixes[suffixNum]
  newValue



global_namespace = global if global?
global_namespace = window if window?
global_namespace.App = {} unless global_namespace.App
global_namespace.App.ChartLib = ChartLib

