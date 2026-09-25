# task 15 file_write -- expected output: 104857600
# build: crystal build --release -o prog 15_file_write.cr    run: ./prog
buffer = Bytes.new(1048576)
buffer.size.times { |i| buffer[i] = (i % 256).to_u8 }

written = 0i64
File.open("out.bin", "wb") do |f|
  100.times do
    f.write(buffer)
    written += buffer.size
  end
  f.flush
  f.fsync
end
puts written
