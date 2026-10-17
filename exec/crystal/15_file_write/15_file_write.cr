# task 15 file_write -- expected output: 419430400
# build: crystal build --release -o prog 15_file_write.cr    run: ./prog
t0 = Time.monotonic
buffer = Bytes.new(1048576)
buffer.size.times { |i| buffer[i] = (i % 256).to_u8 }

written = 0i64
8.times do
  File.open("out.bin", "wb") do |f|
    50.times do
      f.write(buffer)
      written += buffer.size
    end
    f.flush
    f.fsync
  end
end
STDERR.puts "TIME_MS=%.3f" % (Time.monotonic - t0).total_milliseconds
puts written
