# task 07 string_append -- expected output: 1000000
# build: crystal build --release -o prog 07_string_append.cr    run: ./prog
text = ""
1_000_000.times do
  text = text + "x"
end
puts text.size
