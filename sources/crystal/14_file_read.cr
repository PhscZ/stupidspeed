# task 14 file_read -- expected output: 484442112
# build: crystal build --release -o prog 14_file_read.cr    run: ./prog
CHUNK = 1048576
total = 0u64
File.open("data.bin", "rb") do |f|
  buf = Bytes.new(CHUNK)
  while (got = f.read(buf)) > 0
    got.times { |i| total += buf[i].to_u64 }
  end
end
puts total % 4294967296_u64
