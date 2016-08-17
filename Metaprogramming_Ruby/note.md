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

这里定义了一个Greeting类，创建了my_object对象。此时我们可以通过此构件来得到关于他自身的信息:

`my_object.class   #=> Greeting`

他告诉我们他是一个greeting类，我们还可以咨询他包含的实例方法：

`my_object.class.instance_methods(false) # => [:welcome]`

此处的false表示我们只需要他回答自身的方法，不包含继承得来的。

`my_object.class.instance_variables # => [:@text]`

还可以这样来询问他的实例变量。

## Active Record
通过内省机制，Active Record可以查看类的名字，比如类名为movie，Active Record会自动映射到表明为movie的表中，并且它知道如何转换英文单词的单复数。

ActiveRecord::Base在运行时读取数据库的表模式，当表中包含了 title 和 director 俩个字段，Active Record会自动定义相应的访问器，如 title/title= 俩个方法。

也就是说Acitve Recode在程序运行时动态地创建访问器。

Ruby不仅能在运行时访问到构件的信息，还能创建修改它们！

## 打开类
当我们需要创建一个方法来去掉字符串中的标点符号时，你可能会这样做：

	def to_aplphanumeric(s)
		s.gsub(/[^\w\s]/,'')
	end

不过在面向对象语言中，更好的方法应该是让字符串本身来处理这样的事情，而不是调用外部的方法来处理。

在ruby中可以这样来实现：

	class String
		def to_aplphanumeric
			gsub(/[^\w\s]/, '')
		end
	end

这样我们就可以直接使用String.to_aplphanumeric 来去除符号了

在ruby中，当第一次提及一个class时，会定义这个类。如果是之后再次提及时，ruby会打开这个类，并为之定义其他属性。

## 猴子补丁
当我们打开类，并为之添加了一个函数时，需要注意你可能会覆盖掉该类原有的方法，并且可能会造成一些BUG。

在动态语言中，不修改源代码而对功能进行追加和变更，人们将之称为：猴子补丁。

使用猴子补丁一定要十分小心，为某个类定义新方法时一定要检查一下该类是否已经存在同名方法。

## 实例变量和方法

与java不一样，实例变量与对象的类没有关系。对于同一个类我们可以创建拥有不同实例变量的对象。

	class Myclass
		def my_method
			@v = 1
		end
		
		def say_hello
			p "hello"
		end
	end
	
	ob1 = Myclass.new
	ob1.my_method
	ob1.instance_variables #=> [:@v]
		
	ob2 = Myclass.new
	ob2.instance_variables #=> []
	
	Myclass.instance_methods #=>[:my_method, :say_hello, ...]
	ob2.instance_methods #=> error

由此我们可以看到对象中有实例变量，并且同一个类的不同对象可以有不同的实例变量。

而当我们想要找对象中的方法的时候，结果却是报错 `undefined method 'instance_methods'`

**共享同一个类的对象也共享同样的方法，因此方法存在类中，而非对象中**, 所以我们可以通过 `Myclass.instance_methods` 来查看该类的对象可以调用的方法。

值得一提的是在这里我们不能说 Myclass 有一个叫 my_method()的方法，因为这样会让人误以为它是一个类方法，可以这样调用`Myclass.my_method()`。

而实际上 my_method() 是Myclass的一个实例方法，需要定义一个Myclass的实例对象才能调用 `ob1.my_method()`

理解了类方法和实例方法的区别，看下面的自省方法才不会困惑：

	String.intance_methods == "abc".methods  #=> true
	String.methods == "abc".methods #=> false
