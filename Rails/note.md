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

	class StaticPagesController < ApplicationController
		def home
		end
	end

因为controller继承了 ApplitionController, 当访问/static_pages/home时，rails会在StaticPages中寻找home动作，然后执行改动作，再渲染相应的视图。

## 什么时候应该先写测试（摘抄）

* 与应用代码相比，测试代码特别简短，倾向先写测试
* 对想要实现的功能不是特别清楚，倾向于先写应用代码，然后再写测试，并改进实现方式
* 为安全相关的功能先编写测试
* 只要发现一个问题，**就编写一个测试重现重问题**，避免回归，然后再编写应用代码修改问题
* 尽量不为以后可能修改的代码编写测试（如html结构的细节）
* 重构之前要编写测试， 集中测试容易出错的代码

一般先编写控制器和模型测试，然后再编写集成测试。

## TDD

先编写一个失败测试，然后编写应用代码让测试通过，最后再根据需求重构代码。

> 遇红-变绿-重构

## MiniTest

在测试辅助文件 `test/test_helper.rb` 中引入minitest，可以让Rails应用的测试适时的编程红色和绿色。

	require 'minitest/reporters'
	Minitest::Reporters.use!

## 使用Guard 自动测试

为了避免每次写完代码都要切换到命令行然后手动测试，我们可以使用Guard自动测试。Guard会监测文件系统的变动，并只会运行这个文件中的测试。

* 在gemfile中加入 guard gem
* 初始化：bundle exec guard init
* 编辑生成的Guardfile文件，让Guard在集成测试和视图发生变化后运行正确的测试
* 运行 bundle exec guard 开启自动测试

## Model

控制器名是复数，模型名是单数：控制器是 Users，而模型是 User。

模型表示单个用户，而数据库表中存储了很多用户: 数据库表是 users, 而模型是 User

User < ApplicationRecord < ActiveRecord::Base

## 迁移文件

change 方法用来定义要对数据库进行什么操作。

使用create_table 方法来新建一个表。

使用rails db:migrate 命令来向上迁移

迁移都是可逆的，撤销上面的迁移可以使用

	rails db:rollback

这个命令会调用drop_table方法，将新建的users表删除，对应新建时的 create_table方法。

## model验证

验证不能为空,长度,唯一性

	validates :name, presence: true, length: { maximum: 50 }, uniqueness: { case_sensitive: true }

查看错误信息

	user.errors.full_messages

Active Record 中的唯一性验证无法保证数据库层也能实现唯一性

在model层建立的唯一性验证会在拥有一定访问量的时候，出现俩条email一样的数据。

解决方法是在数据库层也加上唯一性验证，为email建立索引，然后为索引添加唯一性验证。

## 索引

建立索引

	rails generate migration add_index_to_users_email

添加邮件唯一性迁移

	add_index :users, :email, unique: true

索引本身不保证唯一性，所以需要添加 unique: true

## 使用安全密码机制

使用Rails 中的一个方法基本就能实现了

	has_secure_password

使用了这个方法后，会自动添加以下的功能

* 在数据库中的password_digest 列存储安全的密码哈希值
* 获得一对虚拟属性，password 和 password_confirmation，而且在创建用户的时候会执行存在性检验和匹配验证
* 获得 authenticate方法，如果密码正确，返回相应的用户对象，否则反回false

使用 has_secure_password的唯一要求是对应的模型中需要有password_digest的属性。

新建迁移为User添加password_digest列

	rails generate migration add_password_digest_to_users password_digest:string

这里迁移的名字以_to_users 结尾，rails 会自动生成一个向users表添加列的迁移

has_secure_password 使用先进的bcrypt哈希算法密码摘要，我们这里引入bcrypt gem

	gem 'bcrypt', '3.1.11'

has_secure_password 本身会验证存在性，但是只会验证没有密码，不能监测到比如"     "这样无效的密码

所以我们在这基础上需要在modle中添加存在性验证

	validates :password, presence: true, length{ minimum: 6 }

使用has_secure_password提供的authenticate("password")，这个方法会判断用户提供的密码是否正确
* 错误返回false
* 正确则返回对应的用户

## 使用内置的debug方法和params变量

	<%= debug(params) if Rails.env.development? %>

只需要在开发环境中显示调试信息

## 使用debugger，进行断点调试

	Userscontroller:
	def show
		@user = User.find(params[:id])
		debugger
	end

当访问show动作时控制台会出像(byebug)提示符：

	(byebug)
	(byebug) @user.name
	"jundy"

ctrl-D 退出byebug

当觉的哪里有问题的时候，在可能产生问题的代码附近加上debugger

在byebug中可以使用to_yaml方法查看完整的对象属性

	(byebug) puts @user.attributes.to_yaml
	
	---
	id: 1
	name: hello
	email: hellojundy@163.com
	created_at: !ruby/object:ActiveSupport::TimeWithZone
	utc: &1 2015-09-09 08:11:45.512430000 Z
	zone: &2 !ruby/object:ActiveSupport::TimeZone
	name: Etc/UTC
	time: *1
	updated_at: !ruby/object:ActiveSupport::TimeWithZone
	utc: &3 2016-09-14 05:42:20.574433000 Z
	zone: *2
	time: *3
	password_digest: "$2a$10$J7lknJD5dre3oErGTDquTulsvf/DB9EOCWzQi0nVJkL6T.guWlKWa"

## 显示用户头像

我们计划使用<%= gravatar_for @user %>来显示

默认情况下，所有的辅助方法都自动在任意视图可用，不过为了方便管理，我们把gravatar_for 方法放在Users 控制器对应的辅助方法文件中。
	
	User_helper.rb:
	
	def gravatar_for(user)
		gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
		gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
		image_tag(gravatar_url, alt: user.name, class: "gravatar")
	end

## pluralize

pluralize 方法的第一个参数是整数，返回值是这个数字和第二个参数组合在一起后，正确的单复数形式

	>> helper.pluralize(2, "woman")
	==> "2 women"

## 会话

HTTP协议没有状态，每个请求都是独立的事件，无法使用之前请求中的信息。

需要用户登录的应用都要使用会话。

会话是两台电脑之间的半永久性链接，如： 运行web浏览器的客户端电脑和运行Rails的服务器。

Rails中实现会话最常见的方式是使用cookie。

## flash

在Rails中，短暂的显示一个消息使用 flash message 实现。

	flash[:success] = "welcome!"
	flash.now[:danger] = "wrong password!" # 只在当前请求中显示
	
	#遍历flash
	flash.each do |key, value|
		puts "#{ key }"
		puts "#{ value }"
	end
	
	=> success
	=> welcome
	=> danger
	=> wrong~

## Session

session 方法创建的临时 cookie 会自动加密，攻击者无法使用会话中的信息以该用户的身份登录。

不过，只有 session 方法创建的临时 cookie 是这样，cookies 方法创建的持久cookie 则有可能会受到会话劫持（session hijacking）攻击。

## find && find_by

	User.find(user_id)
	User.find_by(id: user_id)

find 方法如果ID无效，则抛出异常
find 方法则是返回nil。


## cookie

持久 cookie 有被会话劫持的风险，攻击者可以使用盗取的记忆令牌以某个用户的身份登录。

盗取 cookie 中的信息主要有四种方法

* 使用包嗅探工具截获不安全网络中传输的 cookie
* 获取包含记忆令牌的数据库
* 使用跨站脚本（Cross-Site Scripting，简称 XSS）攻击
* 获取已登录用户的设备访问权

将user_id 存入 cookie

	cookies[:user_id] = user.id
	
但是这种方法存储的是纯文本，攻击者很容易就能窃取用户的账户，为了避免这样的情况，我们对cookies签名，存入浏览器前安全加密cookie:

	cookies.signed[:user_id] = user.id

因为我们想让用户id和永久的记忆令牌配对，所以也要永久存储用户id,因此我们可以串联调用signed和permanent方法

	cookies.permanent.signed[:user_id] = user.id

存储了之后，我们可以使用一下方法来取回用户

	User.find_by(id: cookies.signed[:user_id])
	


