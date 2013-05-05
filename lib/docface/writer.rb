require 'fileutils'

module DocFace
  class Writer

    def write(directory,file,content)
      if !dir_exists?(directory)
        FileUtils.mkdir_p(directory)
      end
      writer(file,content)
    end

    def dir_exists?(directory)
      File.directory?(directory)
    end

    def writer (file,content)
      File.open(file, 'w') { |file| file.write(content) }
    end

    def assets(source,dest)
      FileUtils.cp_r(source,dest,:remove_destination=>true)
    end

  end
end
