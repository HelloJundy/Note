# -*- coding: utf-8 -*-
module HelloModule
  Version = '1.0'

  def hello(name)
    puts "Hello #{name}"
  end

  module_function :hello # 指定hello为模块
end


p HelloModule::Version
HelloModule.hello("ruby")

include HelloModule

p Version
hello("java")
