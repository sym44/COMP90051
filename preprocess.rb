file = open("train.txt", "r")


num_following = Hash.new
num_follower = Hash.new

file.each_line do |line|
	line_arr = line.split(/[\t\r\n]/)

	# update num_following
	count = line_arr.length - 1
	num_following["#{line_arr[0]}"] = count

	# update num_follower
	line_arr.each do |x|
		if num_follower.has_key?(x)
			v = num_follower[x]
			num_follower[x] = v+1
		else
			num_follower[x] = 0
		end
	end
end

require 'json'

num_following.to_json
num_follower.to_json


json_file = open("feature_following.json", "w")
json_file.write(num_following)
json_file.close

json_file_2 = open("feature_follower.json", "w")
json_file_2.write(num_follower)
json_file_2.close

