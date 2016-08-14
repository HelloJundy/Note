变量/类/方法等成员也可以称为语言构件
## 内省
通过一个构件询问关于他自身的问题，这种方法称为**内省**

```
class Greeting
  def initialize(text)
	@text = text
  end
  
  def welcome
	@text
  end
end

my_object = Greeting.new("Hooooo")
```

	这里定义了一个Greeting类，创建了my_object对象。此时我们可以通过此构件来得到关于他自身的信息
	> my_object.class   #=> Greeting
	他告诉我们他是一个greeting类，我们还可以咨询他包含的实例方法：
	> my_object.class.instance_methods(false) # => [:welcome]
	此处的false表示我们只需要他回答自身的方法，不包含继承得来的。
	> my_object.class.instance_variables # => [:@text]
	还可以这样来询问他的实例变量
