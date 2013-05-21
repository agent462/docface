require 'docface/file_troll'
require 'docface/parser'
require 'docface/writer'
require 'docface/cli'
require 'erb'
require 'rainbow'

module DocFace
  class Base

    def initialize
      cli
      @troll = FileTroll.new
      @writer = Writer.new
      @parser = Parser.new
      @short_files = Array.new
      all_the_things
    end

    def all_the_things
      time = Time.now
      @directory.each do |dir|
        files = @troll.troll(dir)
        parse(files,dir)
      end
      @index_hash = @troll.index_hash(@short_files)
      @troll.cleanup(@index_hash)
      assets
      write_index(build_index("templates/index.erb"))
      time_taken = Time.now - time
      puts "Your build was created at #{@output_dir}.\n\r#{@short_files.count} documents were parsed in #{time_taken} seconds.".color(:cyan)
    end

    def cli
      @cli = Cli.opts
      @directory = @cli[:dir]
      @page_attributes = {
        :title => @cli[:title] || "DocFace",
        :summary => @cli[:summary] || ""
      }
      @output_dir = @cli[:output] ? @cli[:output] : "#{Dir.pwd}/docface"
    end

    def parse(files,directory)
      files.each do |file|
        content = @parser.to_html(File.read(file))
        @short_files << strip_path(file,directory)
        puts file.color(:yellow) if @cli[:verbose]
        build(file,content)
      end
    end

    def strip_path(file,directory)
      dir = directory.gsub(/\/*$/,'').gsub(directory.split('/').last, "")
      file = file.gsub(dir, "")
    end

    def build(file,content)
      file = File.join(@output_dir,file).gsub(/\.md|.MD|.markdown|.mdown/,".html")
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

  end
end
