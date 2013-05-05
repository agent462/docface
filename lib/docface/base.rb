require 'docface/file_troll'
require 'docface/parser'
require 'docface/writer'
require 'erb'
require 'docface/cli'
require 'pp'

module DocFace
  class Base

    def initialize
      cli
      @troll = FileTroll.new
      @writer = Writer.new
      @files = @troll.troll(@directory)
      parse
      sub_index
      # cleanup(@index_hash)
      assets
      write_index(build_index("templates/index.erb"))
    end

    def cli
      @cli = Cli.opts
      @directory = @cli[:dir]
      @output_dir = @cli[:output] ? @cli[:output] : "#{Dir.pwd}/docface"
    end

    def sub_index
      @index.each do |i|
        i.gsub!(/\.md/,".html")
      end
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
      #@index_hash = @troll.index_hash(short_files)
      @index = short_files
    end

    def build(file,content)
      file = File.join(@output_dir,file).gsub(/\.md/,".html")
      directory = File.dirname(file)
      @writer.write(directory,file,content)
    end

    def assets
      @writer.assets(File.join(File.dirname(__FILE__),"../../public"),"#{@output_dir}/public")
    end

    def build_index(path)
      r = ERB.new(File.read(File.join(File.dirname(__FILE__),path)))
      r.result(binding)
    end

    def write_index(content)
      @writer.write(@output_dir,"#{@output_dir}/index.html",content)
    end

    def cleanup(h)
      return true if h.empty?
      h.find_all{|k,v|h[k]=nil if v.is_a?(Hash)&&cleanup(v)}
      false
    end

    def i_hash(h,d=[],s=[])
      h.each do |k,v|
        if v == nil #at the last node
          s.push k
          d << s.join("/")
          s.pop
        else
          s.push k
          i_hash(v,d,s)
          s.pop
        end
      end
      d.sort
    end

  end
end
