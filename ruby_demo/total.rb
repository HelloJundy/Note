def total(from ,to )
  result = 0;
  from.upto(to) do |num|
    if block_given?
      result += yield(num)
    else
      result += num
    end
  end
  result
end

p total(1,5)
p total(1,5){|num| num ** 2}


def total1(from, to, &block)
  total = 0
  if block
    from.upto(to) do |num|
      result += block.call(num)
    end
  else
    resutl += num
  end
end

p total(1,5)
p total(1,5){|num| num ** 2}
