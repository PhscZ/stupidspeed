# task 02 switch_case -- expected output: 7500000075000000
# build: crystal build --release -o prog 02_switch_case.cr    run: ./prog
# note: Crystal integer literals default to Int32; task 02 needs the Int64 form or it raises OverflowError.
acc = 0i64

100000000.times do |i|
  case i % 4
  when 0
    acc += 1
  when 1
    acc += i
  when 2
    acc += 2 * i
  when 3
    acc += 3 * i
  end
end

puts acc
