# task 06 char_count — expected output: 10000000
# build: none (interpreted)    run: ruby 06_char_count.rb (cruby) | ruby --yjit 06_char_count.rb (cruby+yjit) | jruby 06_char_count.rb (jruby, needs Java 25)
# The stock Windows CRuby build has no YJIT: `ruby --yjit` warns "Ruby was built without YJIT support".

text = 'abcdefghij' * 10_000_000

count = 0
text.each_char do |ch|
  if ch == 'a'
    next
  elsif ch == 'e'
    next
  elsif ch == 'h'
    count += 1
  end
end

puts count
