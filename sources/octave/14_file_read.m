# task 14 file_read — expected output: 2389704704
# build: none (interpreted)    run: octave-cli -qf 14_file_read.m
#
# data.bin is 52428800 bytes, the bytes 0..255 repeating, opened from the working
# directory and read in 1 MiB chunks, never a byte per syscall. The bytes are
# added one at a time in a loop, the same per-byte accumulation every other row
# runs; the accumulation is exact because the total before the modulus
# (6684672000) is far below 2^53. The modulus is taken once, at the end.
# (Adding a chunk with a single sum() call would be a vectorised bulk aggregate
# in the timed path, which is not the loop the task asks for.)
# note: chunked fread plus a per-byte loop is the deviation the merged R row
# already records in sources/r/14_file_read.R.
# note: every byte goes through double(). fread returns doubles by default, but a
# uint8 read back into the accumulator would make the accumulator a uint8 and
# Octave's integer arithmetic saturates, so the total would stop at 255.

__t0 = tic;
fid = fopen('data.bin', 'rb');
total = 0;
while true
  chunk = fread(fid, 1048576, 'uint8');
  n = numel(chunk);
  if n == 0
    break;
  end
  for i = 1:n
    total = total + double(chunk(i));
  end
  if n < 1048576
    break;
  end
end
fclose(fid);
fprintf(stderr, "TIME_MS=%.3f\n", toc(__t0) * 1000);
printf("%.0f\n", mod(total, 4294967296));
