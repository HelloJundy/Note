# 1
def cels2fahr (cels)
  cels * 9 / 5 + 32
end

p cels2fahr 32.2

def fahr2cels(fahr)
  (fahr - 32) * 5 / 9
end

1.upto(100) do |i|
  p fahr2cels(i)
end

# 3
def dice
  Random.rand(6) + 1
end

100.times do |i|
  p dice
end

def dice10
  10.times.collect{ dice }
end

p dice10

def prime?(num)
  (2...num).each do |i|
    p num
    p i
    p '---------------'
    return false if num % i == 0
  end
  num == 0 || num == 1 ? false : true 
end

p 100.times.select{|i| i if prime? i}
