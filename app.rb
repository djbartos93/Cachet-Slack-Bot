require 'http'
require 'json'
require 'uri'
require 'yajl'
require 'json-compare'

  #puts JSON.pretty_generate(JSON.parse(s1.body))
def read_1
  url = URI("http://172.16.3.84/api/v1/components")

  http = Net::HTTP.new(url.host, url.port)
  http.use_ssl = false

  request = Net::HTTP::Get.new(url)

  response = http.request(request)
  @read1 = JSON.pretty_generate(JSON.parse(response.read_body))
  service_name = JSON.parse(response.read_body)['data'][0]['name']
  status_name = JSON.parse(response.read_body)['data'][0]['status_name']
  status_code = JSON.parse(response.read_body)['data'][0]['status']
  puts status_code
  @update = '*A service has changed status:* ' + service_name + ' is now at status: ' + status_name
  if status_code > 1
    slack_down
  else
    slack_up
  end
end

def slack_up
  rc = HTTP.post("https://slack.com/api/chat.postMessage", params:{
    token: ENV['SLACK_API_TOKEN'],
    channel: 'test-emails',
    text: @update,
    icon_emoji: ':white_check_mark:'
    })
  puts JSON.pretty_generate(JSON.parse(rc.body))
end

def slack_down
  rc = HTTP.post("https://slack.com/api/chat.postMessage", params:{
    token: ENV['SLACK_API_TOKEN'],
    channel: 'test-emails',
    text: @update,
    icon_emoji: ':red_circle:'
    })
  puts JSON.pretty_generate(JSON.parse(rc.body))
end

def read_2
  url = URI("http://172.16.3.84/api/v1/components")

  http = Net::HTTP.new(url.host, url.port)
  http.use_ssl = false

  request = Net::HTTP::Get.new(url)

  response = http.request(request)
  @read2 = JSON.pretty_generate(JSON.parse(response.read_body))
  #uts @read2
end

def compare
  old, new = Yajl::Parser.parse(@read1), Yajl::Parser.parse(@read2)
  result = JsonCompare.get_diff(old, new)
  puts result
end

def check
  read_1
  puts @read1
  sleep(10)
  read_2
  puts @read2
end

def run1
  check
  sleep(1)
  compare
end

puts read_1
