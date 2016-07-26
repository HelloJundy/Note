a = [1,2,3,4,5]
a.unshift(0)

p a

a << 6
a.push 7
p a

b = ['a','b','c','d']
c = a + b
p c
a.concat b

p a
a[2,0] = nil
a << nil
p a
a.compact!

p a

a.delete(2)

p a

p a.delete_at(2)

a.delete_if{|i| i.is_a?(String) || i.even?}

p a

p a.reject!{|i| i < 3}
p a

a << b
p a
p a.flatten

d = (1..10).map{|i| i}.reduce(:*)
p d

e = Array.new(3,[0,0,0])
p e
