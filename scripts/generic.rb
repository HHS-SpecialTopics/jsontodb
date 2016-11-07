print 'Processor: '
processor = gets.chomp

print 'URL: '
url = gets.chomp

print 'Source Directory: '
src_dir = gets.chomp

print 'Username: '
user = gets.chomp

print 'Password: '
pass = read_password

puts
puts

if url == ''
  puts 'The specified URL cannot be empty!'
  exit(1)
end



files = Dir["#{src_dir}#{'/' unless src_dir == ''}**/*.json"]

files.each do |file|
end
