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

def reverse(input)
  open(input,"r+") do |f|
    line = f.readlines
    f.rewind
    f.truncate(0)
    f.write line.reverse.join()
  end
end

#reverse(ARGV[0])

def tail(linenum, filename)
  open(filename) do |f|
    lines = f.readlines
    lines[-(linenum.to_i)..-1].each{|l| print l}
  end
end

tail(ARGV[1],ARGV[0])
