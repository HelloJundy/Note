file = File.open("hash1.rb")
file.each_char do |line|
  puts line
end

file.close

File.open("hash1.rb") do |file|
  file.each_line do |line|
    puts line
  end
end
