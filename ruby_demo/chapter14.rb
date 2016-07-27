# 1
s = "Ruby is an object oriented programming language"
a = s.split()
p a

p a.sort

p a.sort{|a,b| a.downcase <=> b.downcase}
p a
p a.collect{|i| i.capitalize}.join(" ")
c = s.each_char.collect{|i| i}.uniq

c.each do |k|
  p "#{k} : #{ "*" * s.count(k)}"
end


def han2num(string)
  
end
