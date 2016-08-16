class Myclass
	def my_method
		@v = 1
	end

	def say_hello
		p "hello"
	end
end
	
ob1 = Myclass.new
p ob1.my_method
p ob1.instance_variables #=> [:@v]

p ob2 = Myclass.new
p ob2.instance_variables #=> []
p Myclass.instance_methods
p ob1.instance_methods #=> error
