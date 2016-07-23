## Ruby Programming
### 8 object
#### 类
* 类变量是所有实例共享的变量，需要直接定义存取器，attr_accesser 不能直接用 ？？
* 一般方法默认为public 但是initialize 默认为private
* protected : 在同一个类中可以当作实例方法来调用
* 一般不指定所继承的类，都会默认继承Ｏbject 类，ＢaseObject 类所拥有的功能是最基础的
* undef 在子类中删除父类的方法
#### module
* 模块不能拥有实例，模块不能被继承
* ruby 不能多重继承，但可以通过Min-in来解这类需求
* 同一个类中包含多个模块，优先查找最后一个模块
* extend 可以使单例类包含模块
### opration
* 最后一个表达式的值为逻辑表达式的返回值
  * `var || 'ruby'` 当var 为false 或者 nil 时 此逻辑表达式返回 ‘ruby’
