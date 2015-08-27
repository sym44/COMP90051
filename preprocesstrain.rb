require 'csv'

fromHash = {}
toHash = {}

File.open("train.txt", "r") do |file|
    while line = file.gets
        lineArray = line.split(/[\t\r\n]/)
        key = lineArray.shift
        if lineArray.length != 0
            fromHash[key] = lineArray
        end
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

i = 0
j = 0
id = 0

CSV.open("result_3.csv", "w+") do |w|
    w << ["Id","from","to","fromout","fromin","toout","toin","width","exist"]

    while i < 100000
        sampleFrom = fromNode[rand(fromNode.length)]
        toArray = fromHash[sampleFrom]
        sampleTo = toArray[rand(toArray.length)]

        if toHash[sampleFrom] == nil
            toHash[sampleFrom] = []
        end
        if fromHash[sampleTo] == nil
            fromHash[sampleTo] = []
        end

        id += 1
        fromout = fromHash[sampleFrom].length
        fromin = toHash[sampleFrom].length
        toout = fromHash[sampleTo].length
        toin = toHash[sampleTo].length

        width = (fromHash[sampleFrom] & toHash[sampleTo]).length
        exist = 1

        w << [id,sampleFrom,sampleTo,fromout,fromin,toout,toin,width,exist]
        puts i
        i += 1
    end

    while j < 100000
        sampleFrom = fromNode[rand(fromNode.length)]
        sampleTo = toNode[rand(toNode.length)]

        if sampleFrom != sampleTo
            if !fromHash[sampleFrom].include?sampleTo
                if toHash[sampleFrom] == nil
                    toHash[sampleFrom] = []
                end
                if fromHash[sampleTo] == nil
                    fromHash[sampleTo] = []
                end

                id += 1
                fromout = fromHash[sampleFrom].length
                fromin = toHash[sampleFrom].length
                toout = fromHash[sampleTo].length
                toin = toHash[sampleTo].length

                width = (fromHash[sampleFrom] & toHash[sampleTo]).length
                exist = 0

                w << [id,sampleFrom,sampleTo,fromout,fromin,toout,toin,width,exist]
                puts j
                j += 1
            end
        end
    end
end

puts "end of write result"
