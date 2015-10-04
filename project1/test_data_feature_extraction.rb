# attach training dataset, and testing dataset
train = open('train.txt', 'r')
test = open('test-public.txt', 'r')


# take out one test case

#puts from_id = test.readline.split(' ')[1]

# while test_case = test.gets do
# 	test_arr = test_case.split(' ')
# 	test_arr.each do |id|
# 		count = 0
# 		while line = train.gets do
# 			arr = line.split(' ')
# 			if (arr[0] != id) && (arr.include?(id))
# 				count += 1
# 			end
# 		end
# 		puts "#{id} + #{count}"
# 	end
# end

id = 85517.to_s
count = 0
while line = train.gets do
	arr = line.split(' ')
	if (arr[0] != id) && (arr.include?(id))
		count += 1
	end
end

puts count