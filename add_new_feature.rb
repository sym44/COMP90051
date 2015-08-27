def newFeature(from, to)
	return 0
end

def newFeatureName
	return "distance"
end

file_temp = open("result_temp.csv", "w")
File.open("result.csv", "r") do |file|
	headline = file.gets
	headline_s = headline.to_s.gsub("\n",",#{newFeatureName}\n")
	file_temp.write(headline_s)

	while line = file.gets
		line_Array = line.split(/[,\n ]/)
		from = line_Array[1]
		to = line_Array[2]

		line_s = line.to_s.gsub("\n", ",#{newFeature(from, to)}\n")
		file_temp.write(line_s)
	end
end
file_temp.close