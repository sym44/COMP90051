result = Array.new

File.open("submission_200k_logistic.txt", "r") do |file|
	line_1 = file.gets
	
	
	while line = file.gets
		last_item = line.to_s.split(/\s/).to_a[-1]
		fmt_last_item = last_item.match(/[.0-9]+$/)
		result << fmt_last_item
	end
end

File.open("submission_200k_logistic.csv", "w") do |file|
	line_1 = "Id,Prediction\n"
	file.write(line_1)

	Id = 1
	
	result.each do |item|
		Prediction = result[Id-1]
		line = "#{Id},#{Prediction}\n"
		file.write(line)
		Id += 1
	end
end
