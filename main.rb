require './kevin_permutations'

kk = KevinPermutations.new(4)

count = 0
kk.each do |perm|
  count += 1
  puts "#{count}: #{perm.inspect}"
end
