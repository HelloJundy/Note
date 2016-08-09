# coding: utf-8
# 1
require 'time'
def cparsedate(time)
  arr = Array.new
  time.scan(/\d*\w/){|str| arr << str}
  t = Time.new(arr[0], arr[1], arr[2], arr[3], arr[4], arr[5])
end

cparsedate '2013年5月18日下午3点17份52秒'

def ls_t(path)
  dir = Dir.open(path)
  dir.each do |name|
    p name
  end
end

ls_t '../ruby_demo'
