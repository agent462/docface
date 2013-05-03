module Doc
  class FileTroll

    def initialize
      @index = Array.new
    end

    def troll(directory)
      path = directory.gsub(/\\(?=\S)/, '/')
      Dir.glob(File.join(path, '**/*.md')).each do |file|
        @index << file
      end
      @index
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

  end
end
