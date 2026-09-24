<?php
// task 06 char_count — expected output: 10000000
// build: none (interpreted)    run: php main.php (zend) | php -d opcache.enable_cli=1 -d opcache.jit_buffer_size=64M main.php (zend + jit)
// The 100 MB text is built once with str_repeat; the scan is an index loop over its bytes.

$text = str_repeat('abcdefghij', 10000000);

$count = 0;
$len = strlen($text);

for ($i = 0; $i < $len; $i++) {
    $ch = $text[$i];
    if ($ch === 'a') {
        continue;
    } elseif ($ch === 'e') {
        continue;
    } elseif ($ch === 'h') {
        $count++;
    }
}

echo $count, "\n";
