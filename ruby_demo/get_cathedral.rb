# coding: utf-8
require "open-uri"
require "nkf"  # 日文win 使用此段代码

url  = "http://cruel.org/freeware/cathedral.html"
filename = "cathedral.html"

File.open(filename, "w") do |f|
  text = open(url).read
  f.write text
  # f.write NKF.nkf("-s", text)
end
