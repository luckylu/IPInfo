require 'open-uri'
require 'json'
class IpInfo
  def initialize(ip)
  	@ip = ip
  end
  def getinfo
  begin
    @contents = URI.parse("http://ip.taobao.com/service/getIpInfo.php?ip=#@ip").read
  rescue Expection
    retry
  end
    @info = JSON.parse(@contents)
    @status = @info["code"]
    @country = @info["data"]["country"]
    @area = @info["data"]["area"]
    @region = @info["data"]["region"]
    @city = @info["data"]["city"]
    @county = @info["data"]["county"]
    @isp = @info["data"]["isp"]
    if @status == 0 and @country == "中国" and !@county.empty?
    puts "#@country-#@area-#@region-#@city-#@county-#@isp"
    elsif @status == 0 and @country == "中国" and @county.empty?
    puts "#@country-#@area-#@region-#@city-#@isp"
    elsif @status == 0 and @country != "中国"
    puts "#@country"
    else 
    puts "输入的IP地址不合法，请重新输入"
    end
  end
end
p = IpInfo.new(ARGV[0])
p.getinfo
