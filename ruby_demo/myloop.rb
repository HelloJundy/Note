def myloop
  100.times do 
    yield
  end
end

i = 0
myloop{ p i+=1 }
