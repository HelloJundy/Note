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
