str = "http://www.ruby-lang.org/js/"
%r|http://([^/]*)/| =~ str
print $1
