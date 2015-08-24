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

puts "end of read train original"

File.open("trainreverse.txt", "r") do |file|
	while line = file.gets
		lineArray = line.split(/[\t\r\n]/)
		key = lineArray.shift
		toHash[key] = lineArray
	end
end

puts "end of read train reverse"

fromNode = fromHash.keys
toNode = toHash.keys
totalNode = (fromNode + toNode).uniq
sampleArray = []

i = 0
j = 0


while i < 100000
	sampleFrom = fromNode[rand(fromNode.length)]
	toArray = fromHash[sampleFrom]
	sampleTo = toArray[rand(toArray.length)]
	samplePair = [sampleFrom,sampleTo]
	if !sampleArray.include?samplePair
		sampleArray << samplePair
		i += 1
		puts i
	end
end

while j < 100000
	sampleFrom = fromNode[rand(fromNode.length)]
	sampleTo = totalNode[rand(totalNode.length)]
	samplePair = [sampleFrom,sampleTo]
	if (sampleFrom != sampleTo) && (!sampleArray.include?samplePair)
		if (fromHash[sampleFrom] == nil) || (!fromHash[sampleFrom].include?sampleTo)
			sampleArray << samplePair
			j += 1
			puts j
		end
	end
end

puts "end of generate sample node pair"

CSV.open("result.csv", "w+") do |w|
	w << ["Id","from","to","fromout","fromin","toout","toin","width","exist"]

	for i in 0..sampleArray.length-1
		id = i + 1
		from = sampleArray[i][0]
		to = sampleArray[i][1]

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
		if fromHash[from].include?to
			exist = 1
		else
			exist = 0
		end
		w << [id,from,to,fromout,fromin,toout,toin,width,exist]
		puts id
	end
end

puts "end of write result"
