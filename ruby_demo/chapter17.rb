#
row = 0
word = 0
char = 0
File.open("text.txt") do |io|
  io.each_line do |line|
    row += 1
    word += line.split.size
    char += line.length
  end
end

p row
p word
p char

arr = Array.new()
File.open("text.txt","r+") do |io|
  io.each_line do |line|
   p arr << line
  end
  io.rewind
  io.write(arr.reverse.join(""))
end


