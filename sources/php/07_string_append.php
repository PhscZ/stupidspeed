<?php
// task 07 string_append — expected output: 1000000
// build: none (interpreted)    run: php 07_string_append.php (zend) | php -d opcache.enable_cli=1 -d opcache.jit_buffer_size=64M 07_string_append.php (zend + jit)
// `$text = $text . 'x'` is PHP's plain concatenation: ZEND_CONCAT allocates a fresh string
// every iteration. `.=` would be the in-place grow path (zend_string_extend), which is a
// different task and would not be comparable with the other languages.

$text = '';

for ($i = 0; $i < 1000000; $i++) {
    $text = $text . 'x';
}

echo strlen($text), "\n";
