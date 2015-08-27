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

testArray = []

File.open("test.txt", "r") do |file|
    line = file.gets
    while line = file.gets
        lineArray = line.split(/[\t\r\n]/)
        testArray << [lineArray[1],lineArray[2]]
    end
end

puts "end of read test"

CSV.open("testresult.csv", "w+") do |w|
    w << ["Id","from","to","fromout","fromin","toout","toin","fromrate","torate","width","cofrom","coto","exist"]
    for i in 0..testArray.length-1
        id = i + 1
        from = testArray[i][0]
        to = testArray[i][1]

        if toHash[from] == nil
            toHash[from] = []
        end
        if fromHash[to] == nil
            fromHash[to] = []
        end

        fromout = fromHash[from].length
        fromin = toHash[from].length
        toout = fromHash[to].length
        toin = toHash[to].length

        fromrate = fromin.to_f / fromout
        torate = toout.to_f / toin

        width = (fromHash[from] & toHash[to]).length

        intersection = (fromHash[from] & fromHash[to]).length
        union = (fromHash[from] | fromHash[to]).length
        cofrom = intersection.to_f / union

        intersection = (toHash[from] & toHash[to]).length
        union = (toHash[from] | toHash[to]).length
        coto = intersection.to_f / union

        exist = '?'

        w << [id,from,to,fromout,fromin,toout,toin,fromrate,torate,width,cofrom,coto,exist]
    end
end

puts "end of write result"
