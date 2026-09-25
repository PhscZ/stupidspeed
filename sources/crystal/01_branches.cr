# task 01 branches -- expected output: 33333334 13333333 7619048 45714285
# build: crystal build --release -o prog 01_branches.cr    run: ./prog
a = 0i64
b = 0i64
c = 0i64
d = 0i64

100000000.times do |i|
  if i % 3 == 0
    a += 1
  elsif i % 5 == 0
    b += 1
  elsif i % 7 == 0
    c += 1
  else
    d += 1
  end
end

puts "#{a} #{b} #{c} #{d}"
