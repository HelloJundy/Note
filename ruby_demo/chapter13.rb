# 1

a = Array.new(100){|i| i+1 }
p a = (1..100).collect{|i| i}

b = a.map{|i| i * 100}
p a
p b
# a.map!{|i| i * 100}
# p a
c = a.select{|i| i % 3 == 0}
p c
# p a.select!{|i| i % 3 == 0}

p a.reverse

p a.reduce(:+)

10.times{ |i| b << a[i*10,10]}
p b


def sum_array(a1,a2)
  c = Array.new
  a1.zip(a2){|a,b| a + b}
end

p sum_array([1,2,3,4],[4,3,2,1])
