module DocFace
  class FileTroll

    def troll(dir)
      if File.directory?(dir)
        index = Array.new
        path = dir.gsub(/\\(?=\S)/, '/')
        Dir.glob(File.join(path, '**/*.{md,MD,markdown,mdown}')).each do |file|
          index << file
        end
        index
      else
        puts "The directory #{dir} does not exist."
        exit
      end
    end

    def index_hash(list)
      tree = Hash.new
      list.sort.each do |w|
        h = tree
        w.split('/').each do |part|
          h = h[part] ||= Hash.new
        end
      end
      tree
    end

    def cleanup(h)
      return true if h.empty?
      h.find_all{|k,v|h[k]=nil if v.is_a?(Hash)&&cleanup(v)}
      false
    end

  end
end
