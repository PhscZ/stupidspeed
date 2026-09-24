# task 07 string_append — expected output: 1000000
# build: perl main.pl    run: perl main.pl
# note: plain string concatenation on a Perl string, which may copy the whole string on every
#       append; no growable-buffer substitute.
use strict;
use warnings;

my $text = '';
for (my $i = 0; $i < 1000000; $i++) {
    $text .= "x";
}

print length($text), "\n";
