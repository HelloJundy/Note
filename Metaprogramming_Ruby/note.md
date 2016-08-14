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

在动态语言中，不修改源代码而对功能进行追加和变更，人们称之为：猴子补丁。
