# task 15 file_write — expected output: 52428800
# build: none (interpreted)    run: octave-cli -qf 15_file_write.m
#
# The buffer is the 1 MiB pattern 0,1,2,...,255 repeated 4096 times, written 50
# times to out.bin. The byte count is the sum of the item counts fwrite reports,
# printed after the flush and the close.
# note: Octave exposes no fsync, so this flushes and closes instead, which is the
# same deviation sources/r/15_file_write.R records. The file is opened "wb"
# because the host is Windows.

__t0 = tic;
buf = repmat(uint8(0:255), 1, 4096);
fid = fopen('out.bin', 'wb');
written = 0;
for i = 1:50
  n = fwrite(fid, buf, 'uint8');
  written = written + n;
end
fflush(fid);
fclose(fid);
fprintf(stderr, "TIME_MS=%.3f\n", toc(__t0) * 1000);
printf("%.0f\n", written);
