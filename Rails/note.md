# Ruby on Rails Tutorial Note

## 模型的继承体系

User 继承自ApplicationRecord 类,而这个类继承自ActionRecord::Base 类，这样对象才能与数据库通讯，才能把数据库中的列看做Ruby中的属性。

## controller 命名

创建的控制器名称会是蛇底式的 `static_pages_controller.rb`, 我们一般使用驼峰式的方式创建 `rails generate controller StaticPages`，这只是一种约定，也可以使用蛇底式 `rails generate controller static_pages`

因为ruby类名使用驼峰式，但是ruby文件名一般使用蛇底式，所以rails生成器使用underscore方式把驼峰式转换成蛇底式

## 撤销操作

当需要更改控制器名字，得删除生成的文件。因为生成控制器的时候还会生成一些辅助文件，这些也是需要撤销的。我们使用`rails destroy`来完成撤销操作

	rails generate controller StaticPages home help
	rails destroy controller StaticPages home help

一般来说上面俩个命令是互相抵消的

迁移命令改变数据库状态：

	rails db:migrate
	
撤销迁移命令：

	rails db:rollback

回归到最开始的状态：

	rails db:roolback VERSION=0

## ApplicationController

	class StaticPagesController < ApplitionController
		def home
		end
	end

因为controller继承了 ApplitionController, 当访问/static_pages/home时，rails会在StaticPages中寻找home动作，然后执行改动作，再渲染相应的视图。

## 什么时候应该先写测试（摘抄）

* 与应用代码相比，测试代码特别简短，倾向先写测试
* 对想要实现的功能不是特别清楚，倾向于先写应用代码，然后再写测试，并改进实现方式
* 为安全相关的功能先编写测试
* 只要发现一个问题，** 就编写一个测试重现重问题 **，避免回归，然后再编写应用代码修改问题
* 尽量不为以后可能修改的代码编写测试（如html结构的细节）
* 重构之前要编写测试， 集中测试容易出错的代码

一般先编写控制器和模型测试，然后再编写集成测试。

## TDD

先编写一个失败测试，然后编写应用代码让测试通过，最后再根据需求重构代码。

> 遇红-变绿-重构

