# -*- coding: utf-8 -*-
module H
  def hello
    p "#{self} is good !" 
  end
end

module B
  def foo
    p self
  end
end
str  = "ruby"

str.extend(H) # 单例类使用extend包含模块，拓展类功能

str.hello

class A
  extend B # 使用extend 定义类方法模块
  # include H  #使用include 定义实例方法模块
end

A.extend(H) # 因为所有的类都是class类的实例方法 所以可以将A当成是一个单例类

A.hello
A.foo
