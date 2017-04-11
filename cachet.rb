require 'http'
require 'json'
require 'uri'
require 'cachet'
include Comparable


#CachetClient = CachetClient.new(ENV['CACHET_API_KEY'], ENV['CACHET_BASE_URL'])
CachetComponents = CachetComponents.new(ENV['CACHET_API_KEY'], ENV['CACHET_BASE_URL'])
#json1 = CachetComponents.list
#json2 = CachetComponents.list
#data = JSON.parse(components_pretty)['data']
#puts components_pretty
#components = CachetComponents.list['body']
#data.each do |k|
#  puts k
#  sleep(3)
#end
#CachetIncidents = CachetIncidents.new(ENV['CACHET_API_KEY'], ENV['CACHET_BASE_URL'])
#CachetMetrics = CachetMetrics.new(ENV['CACHET_API_KEY'], ENV['CACHET_BASE_URL'])
#CachetSubscribers = CachetSubscribers.new(ENV['CACHET_API_KEY'], ENV['CACHET_BASE_URL'])


def thing1
  @read1 = CachetComponents.list['data']
  sleep(4)
  @read2 = CachetComponents.list['data']
  @read1.each do |start1|
    puts start1['id']
    puts @read2['id']
  end
end

def compare
  @read1.each do |start1|
    puts start1['id']
    puts @read2['id']
  end
end

def initialize
  data_hash = JSON.parse(CachetComponents.list)
  @id = data_hash['id']
  @status = data_hash['status']
  @name = data_hash['name']
  @status_name = data_hash['status_name']
end

initialize
