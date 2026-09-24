# task 14 file_read — expected output: 484442112
# build: none (interpreted)    run: ruby 14_file_read.rb (cruby) | ruby --yjit 14_file_read.rb (cruby+yjit) | jruby 14_file_read.rb (jruby, needs Java 25)
# The stock Windows CRuby build has no YJIT: `ruby --yjit` warns "Ruby was built without YJIT support".
# Reads data.bin (104857600 bytes, the bytes 0..255 repeating) from the working directory in 1 MiB chunks.

total = 0
File.open('data.bin', 'rb') do |f|
  while (chunk = f.read(1 << 20))
    chunk.each_byte { |byte| total += byte }
  end
end

puts total % 4294967296
