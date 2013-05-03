require 'doc/file_troll'
require 'doc/parser'
require 'doc/writer'
require 'erb'
require 'pp'

module Doc
  class Base

    def initialize
      @troll = FileTroll.new
      @writer = Writer.new
      @directory = "/Users/a304092/git/chef"
      @files = @troll.troll(@directory)
      parse
      cleanup(@index_hash)
      pp @index_hash
      assets
      write_index(build_index("templates/index.erb"))
    end

    def parse
      short_files = Array.new
      parser = Parser.new
      @files.each do |file|
        content = parser.to_html(File.read(file))
        dir = @directory.gsub(@directory.split('/').last, "")
        file = file.gsub(dir, "")
        short_files << file
        build(file,content)
      end
      @index_hash = @troll.index_hash(short_files)
    end

    def build(file,content)
      file = File.join(File.dirname(__FILE__),"../../build",file).gsub(/\.md/,".html")
      directory = File.dirname(file)
      @writer.write(directory,file,content)
    end

    def assets
      @writer.assets(File.join(File.dirname(__FILE__),"../../public"),File.join(File.dirname(__FILE__),"../../build/public"))
    end

    def build_index(path)
      r = ERB.new(File.read(File.join(File.dirname(__FILE__),path)))
      r.result(binding)
    end

    def write_index(content)
      @writer.write(File.join(File.dirname(__FILE__),"../../build/"),File.join(File.dirname(__FILE__),"../../build/index.html"),content)
    end

    def cleanup(h)
      return true if h.empty?
      h.find_all{|k,v|h[k]=nil if v.is_a?(Hash)&&cleanup(v)}
      false
    end

    def i_hash(h)
      h.each do |k,v|
        if v.is_a?(Hash)
          puts k
          i_hash(v)
        else
          puts "=============="
        end
      end
    end

  end
end
