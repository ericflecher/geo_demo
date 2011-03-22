module DeomographicImporter

  def initialize
  end

  def importDemographicFile(fileName = "")
    puts 'Opening the file'
    file = File.new(fileName, "r")
    #First line is trash internal column names used by the source database,we don't need them'
    file.gets
    #Second line is human readable column name
    line = file.gets
    titleArray = line.to_s.split('|')

    puts "Inserting demographic information"
    while (line = file.gets)
      region = DemographicRegion.new()
      splitLine = line.to_s.split("|")
      titleArray.count.times { |i|
      #Columns 0, 1 and 2 are keys used by the source DB, and don't mean anything to us
      #region[titleArray[i]] = splitLine[i] if (i > 2)
        placeIntoHashTree(region, titleArray[i], splitLine[i]) if (i > 2)
      }
      #prints the location name so we can see progress
      puts region["Geography"]
      region.save
    end
  end


#Places a value into the document tree
  def placeIntoHashTree(hash, path, value)
    splitPath = path.split(%r{\s*[:;]\s*})
    deeper(hash, splitPath, value)
  end

#Adds a node to the tree if needed, and recursively works its way deeper until reaching the leaf it needs to place the data in
  def deeper(hash, remainingLevels, value)
    node = remainingLevels.shift
    node.gsub!("$", "-s-")
    if (hash[node].nil?)
      hash[node] = remainingLevels.empty? ? value : Hash.new
      deeper(hash[node], remainingLevels, value) if !remainingLevels.empty?
    else
      hash[node] = value if remainingLevels.empty?
      deeper(hash[node], remainingLevels, value) if !remainingLevels.empty?
    end
  end
end