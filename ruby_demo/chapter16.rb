# coding: utf-8
# 1
email = "hellojundy@163.com"
/(\w*)@(\w+)\.\w+/ =~ email
p $1
p $2

# 2
str = "正则表达式真难，怎么这么难懂"
str.gsub!(/(难)/).with_index do |x,i|
   i == 0 ? '简单' : '易'
end
p str
# 3

def word_captilize (str)
  str.split("-").map{|x| x.capitalize}.join("_")
end

p word_captilize("hello-world")
