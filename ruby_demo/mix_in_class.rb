# -*- coding: utf-8 -*-
module Hello
  def foo
    self
  end
end

class A1
  include Hello
  
  def test
    p foo
  end
end

class A2
  include Hello

  def test
    p foo
  end
end

a = A2.new()
a.test   # A2的实例对象  因为include module(mix-in)之后，foo成了该类的实例方法

b = A1.new()
b.test

p A1.include?(Hello)


p A1.ancestors
