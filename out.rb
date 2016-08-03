$stdout.print "Out put to $stdout.\n"
$stderr.print "Out put to $stderr. \n"

io = File.open("ruby.md")

io.each_line do |line|
  printf("%3d %s", io.lineno, line)
end

io.close if io.eof?

File.open("ruby.md") do |io|
  p io.gets(5)
  p io.pos
  io.pos = 0
  p io.gets
end

File.open("log.txt","w") do |io|
  io.print("hello wkorld \n")
end

IO.popen("clear","w")

require "open-uri"

open("https://www.ruby-china.org") do |io|
  puts io.read
end
