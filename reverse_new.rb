fromHash = {}
toHash = {}

File.open("train.txt", "r") do |file|
	while line = file.gets
		lineArray = line.split(/[\t\r\n]/)
		key = lineArray.shift
		fromHash[key] = lineArray
	end
end

puts "end of read"

fromHash.keys.each do |k|
	value = fromHash[k]
	value.each do |v|
		if toHash[v] == nil
			toHash[v] = []
		end
		toHash[v] << k
	end
end

puts "end of from to"

toFile = File.new("trainreverse.txt", "w+")

toHash.keys.each do |k|
	toArray = [k] + toHash[k]
	toline = toArray.join("\t")
	toFile.syswrite(toline + "\r\n")
end

toFile.close

puts "end of toFile"