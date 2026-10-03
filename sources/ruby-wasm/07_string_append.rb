# task 07 string_append — expected output: 250000
# build: none (interpreted)    run: ruby 07_string_append.rb (cruby) | ruby --yjit 07_string_append.rb (cruby+yjit) | jruby 07_string_append.rb (jruby, needs Java 25)
# build (wasm): ruby.wasm is the wasip1 build from ruby/ruby.wasm (see BUILD.md); run: wasmtime --dir . ruby.wasm <task>.rb
# The stock Windows CRuby build has no YJIT: `ruby --yjit` warns "Ruby was built without YJIT support".
# Plain String#+ allocates a fresh string every time; `<<` would mutate in place and is not used.

text = ''
i = 0
while i < 250_000
  text = text + 'x'
  i += 1
end

puts text.length
