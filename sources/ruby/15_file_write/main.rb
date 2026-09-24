# task 15 file_write — expected output: 104857600
# build: none (interpreted)    run: ruby main.rb (cruby) | ruby --yjit main.rb (cruby+yjit) | jruby main.rb (jruby, needs Java 25)
# The stock Windows CRuby build has no YJIT: `ruby --yjit` warns "Ruby was built without YJIT support".
# Writes out.bin: the 1 MiB pattern 0,1,2,...,255 repeated 4096 times, written 100 times.

buffer = (0..255).to_a.pack('C*') * 4096

written = 0
File.open('out.bin', 'wb') do |f|
  100.times do
    written += f.write(buffer)
  end
  f.flush
  f.fsync
end

puts written
