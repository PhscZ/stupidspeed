# task 14 file_read — expected output: 2389704704
# build: none (interpreted)    run: ruby 14_file_read.rb (cruby) | ruby --yjit 14_file_read.rb (cruby+yjit) | jruby 14_file_read.rb (jruby, needs Java 25)
# build (wasm): ruby.wasm is the wasip1 build from ruby/ruby.wasm (see BUILD.md); run: wasmtime --dir . ruby.wasm <task>.rb
# The stock Windows CRuby build has no YJIT: `ruby --yjit` warns "Ruby was built without YJIT support".
# Reads data.bin (52428800 bytes, the bytes 0..255 repeating) from the working directory in 1 MiB chunks.

_t0 = Process.clock_gettime(Process::CLOCK_MONOTONIC)
total = 0
File.open('data.bin', 'rb') do |f|
  while (chunk = f.read(1 << 20))
    chunk.each_byte { |byte| total += byte }
  end
end

_t1 = Process.clock_gettime(Process::CLOCK_MONOTONIC)
$stderr.write("TIME_MS=%.3f\n" % ((_t1 - _t0) * 1000.0))
puts total % 4294967296
