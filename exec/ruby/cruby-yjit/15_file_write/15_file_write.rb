# task 15 file_write — expected output: 419430400
# build: none (interpreted)    run: ruby --yjit 15_file_write.rb (cruby+yjit)
# The stock Windows CRuby build has no YJIT: `ruby --yjit` warns "Ruby was built without YJIT support".
# Writes out.bin: the 1 MiB pattern 0,1,2,...,255 repeated 4096 times, built once and written
# 50 times per pass, 8 passes over the file (reopened at offset 0 each pass), with a flush and
# an fsync per pass.

_t0 = Process.clock_gettime(Process::CLOCK_MONOTONIC)
buffer = (0..255).to_a.pack('C*') * 4096

written = 0
8.times do
  File.open('out.bin', 'wb') do |f|
    50.times do
      written += f.write(buffer)
    end
    f.flush
    f.fsync
  end
end

_t1 = Process.clock_gettime(Process::CLOCK_MONOTONIC)
$stderr.write("TIME_MS=%.3f\n" % ((_t1 - _t0) * 1000.0))
puts written
