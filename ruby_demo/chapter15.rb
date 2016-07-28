# -*- coding: utf-8 -*-
# 1
wday = {sunny: "星期天", monday: "星期一", saturday: "星期六"}

p wday[:sunny]

# 2
p wday.size
p wday.length

# 3
wday.each do |key, value|
  printf("'%s'%s%s\n",key,"是",value)
end

# 4

def str2hash(str)
  h = Hash.new(" ")
  str.split.each_slice(2){|str| h[str[0]] = str[1] ? str[1] : " "}
  p h
end

str2hash "a b c s d r d\n d s d l"
