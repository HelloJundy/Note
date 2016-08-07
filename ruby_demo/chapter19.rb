# coding: utf-8
# 1
def to_utf8(str_gbk, str_gb2312)
  #  str = str_gbk + str_gb2312
  p str_gbk.concat(str_gb2312).encode("UTF-8")
#  p str.encode("UTF-8")
end

to_utf8("love".encode("GBK"), "you".encode("GB2312"))


File.open("test.txt","w:GBK") do |f|
  str = "你好"
  str.encode("GBK")
  f.write(str)
end

File.open("test.txt","r:GBK") do |f|
  f.each_line do |line|
    p line.encode("UTF-8")
  end
end
