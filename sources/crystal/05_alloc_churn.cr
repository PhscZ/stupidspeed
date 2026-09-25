# task 05 alloc_churn -- expected output: 1274991808
# build: crystal build --release -o prog 05_alloc_churn.cr    run: ./prog
total = 0i64
slots = Array(Bytes?).new(256, nil)

10_000_000.times do |i|
  buf = Bytes.new(64)
  buf[0] = (i % 256).to_u8
  total += buf[0].to_i64
  slots[i % 256] = buf
end
puts total
