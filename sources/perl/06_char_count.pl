# task 06 char_count — expected output: 10000000
# build: perl 06_char_count.pl    run: perl 06_char_count.pl
# note: the 100000000-character text is built once by repeating the 10-character block, never by
#       appending, and the scan is a per-character index loop over substr, deliberately not a regex
#       (no tr, no s///, no /h/g).
use strict;
use warnings;

my $text = "abcdefghij" x 10000000;
my $len = length($text);
my $count = 0;

for (my $i = 0; $i < $len; $i++) {
    if (substr($text, $i, 1) eq 'h') {
        $count++;
    }
}

print $count, "\n";
