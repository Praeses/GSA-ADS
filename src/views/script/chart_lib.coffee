
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
  value.toString().replace(/000([^000]*)$/,'K')



global_namespace = global if global?
global_namespace = window if window?
global_namespace.App = {} unless global_namespace.App
global_namespace.App.ChartLib = ChartLib

