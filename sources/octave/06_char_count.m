# task 06 char_count — expected output: 10000000
# build: none (interpreted)    run: octave-cli -qf 06_char_count.m
#
# The 100 MB text is built in one allocation by repeating the ten-character
# block, never by appending in a loop, exactly as the spec asks. Octave strings
# are plain 1-D character arrays, so text(i) is the per-character step, one
# indexed load per character and no intermediate string.

text = repmat('abcdefghij', 1, 10000000);
n = numel(text);
count = 0;
for i = 1:n
  ch = text(i);
  if ch == 'a'
    # skip
  elseif ch == 'e'
    # skip
  elseif ch == 'h'
    count = count + 1;
  end
end
printf("%.0f\n", count);
