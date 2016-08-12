# 1
def my_collect(obj, &block)
  block.call(obj)
end

p my_collect([2,3,4,5]){ |i| i * 2}

# 2
to_class = :class.to_proc
p to_class.call("test")
p to_class.call(123)
p to_class.call(2 ** 1000)
# 3
def accumlator
  total = 0
  Proc.new do |num|
    total += num
  end
end

acc = accumlator

p acc.call(1)
p acc.call(2)
p acc.call(3)
p acc.call(4)
