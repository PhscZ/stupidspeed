# task 15 file_write — expected output: 52428800
# build: none (interpreted)    run: ruby 15_file_write.rb (cruby) | ruby --yjit 15_file_write.rb (cruby+yjit) | jruby 15_file_write.rb (jruby, needs Java 25)
# build (wasm): ruby.wasm is the wasip1 build from ruby/ruby.wasm (see BUILD.md); run: wasmtime --dir . ruby.wasm <task>.rb
# The stock Windows CRuby build has no YJIT: `ruby --yjit` warns "Ruby was built without YJIT support".
# Writes out.bin: the 1 MiB pattern 0,1,2,...,255 repeated 4096 times, written 50 times.

_t0 = Process.clock_gettime(Process::CLOCK_MONOTONIC)
buffer = (0..255).to_a.pack('C*') * 4096

written = 0
File.open('out.bin', 'wb') do |f|
  50.times do
    written += f.write(buffer)
  end
  f.flush
  f.fsync
end

_t1 = Process.clock_gettime(Process::CLOCK_MONOTONIC)
$stderr.write("TIME_MS=%.3f\n" % ((_t1 - _t0) * 1000.0))
puts written
