str1 = "ruby"
str2 = "ruby"


def str1.hello
  "hello , #{self}"
end

class << str2
  def touch
    "hello, #{self}"
  end
end

p str1.hello
p str2.touch
p str2.hello
