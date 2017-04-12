require 'http'
require 'json'
require 'uri'
require 'cachet'
require 'influxdb'
include Comparable


#################====CACHET API STUFF===#########################

#CachetClient = CachetClient.new(ENV['CACHET_API_KEY'], ENV['CACHET_BASE_URL'])
CachetComponents = CachetComponents.new(ENV['CACHET_API_KEY'], ENV['CACHET_BASE_URL'])
#CachetIncidents = CachetIncidents.new(ENV['CACHET_API_KEY'], ENV['CACHET_BASE_URL'])
#CachetMetrics = CachetMetrics.new(ENV['CACHET_API_KEY'], ENV['CACHET_BASE_URL'])
#CachetSubscribers = CachetSubscribers.new(ENV['CACHET_API_KEY'], ENV['CACHET_BASE_URL'])


#################====write to InfluxDB stuff===#########################
#this will write to influxdb
def influx(component_id, component_name, status_id, status_name)
  #lets define some stuff about our database, this should probablyl be env variables
  #username = 'graf' #FUTURE
  #password = 'graffing' #FUTURE
  database = "home"
  #name = valuename
  host = "172.16.0.34"

  influxdb = InfluxDB::Client.new  database: database, host: host
  name = component_name
  data = {
    values: { component: component_id, status_id: status_id, },
    tags:   { stat: component_name, readable: status_name } # tags are optional
  }

  influxdb.write_point(name, data)
  puts data
  #puts dataout
end

#wrtie to influxdb
def cachet_read
data = JSON.parse(CachetComponents.list)['data']
puts data
data.each do |d|
  d['id'] = statusID
end

cachet_read



#json1 = CachetComponents.list
#json2 = CachetComponents.list
#data = JSON.parse(components_pretty)['data']
#puts components_pretty
#components = CachetComponents.list['body']
#data.each do |k|
#  puts k
#  sleep(3)
#end
