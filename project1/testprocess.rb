require 'csv'

fromHash = {}
toHash = {}

File.open("train.txt", "r") do |file|
	while line = file.gets
		lineArray = line.split(/[\t\r\n]/)
		key = lineArray.shift
		fromHash[key] = lineArray
	end
end

puts "end of read sample original"

File.open("samplereverse.txt", "r") do |file|
	while line = file.gets
		lineArray = line.split(/[\t\r\n]/)
		key = lineArray.shift
		toHash[key] = lineArray
	end
end

puts "end of read sample reverse"

testArray = []

File.open("test-public.txt", "r") do |file|
	line = file.gets
	while line = file.gets
		lineArray = line.split(/[\t\r\n]/)
		testArray << [lineArray[1],lineArray[2]]
	end
end

puts "end of read test"

CSV.open("testresult.csv", "w+") do |w|
	w << ["Id","from","to","fromout","fromin","toout","toin","width","exist"]
	for i in 0..testArray.length-1
		id = i + 1
		from = testArray[i][0]
		to = testArray[i][1]

		if fromHash[from] == nil
			fromHash[from] = []
		end
		if toHash[from] == nil
			toHash[from] = []
		end
		if fromHash[to] == nil
			fromHash[to] = []
		end
		if toHash[to] == nil
			toHash[to] = []
		end

		fromout = fromHash[from].length
		fromin = toHash[from].length
		toout = fromHash[to].length
		toin = toHash[to].length

		width = (fromHash[from] & toHash[to]).length
		exist = "?"
		w << [id,from,to,fromout,fromin,toout,toin,width,exist]
	end
end

puts "end of write result"
