require 'trollop'
require 'rainbow'
require 'docface/version'

module DocFace
  class Cli

    def opts
      DocFace::Cli.opts
    end

    def self.opts
      opts = Trollop::options do
        version "DocFace version: #{DocFace::VERSION} (c) 2013 Bryan Brandau"
        banner <<-EOS.gsub(/^ {10}/, '')
          #
          #
          # Welcome to DocFace #{DocFace::VERSION}.
          #
          #    (╯°□°）╯︵ ┻━┻
          #

          ** DocFace Commands **
          docface (options)\r

        EOS
        banner <<-EOS.gsub(/^ {10}/, '').color(:cyan)

          Example Usage: docface -d ~/git/chef
          For help use: docface --help
        EOS
        opt :dir, "The directories to scan for markdown files", :short => "d", :type => :string, :required => true
        opt :output, "The directory to write the generated output to", :short => "o", :type => :string
        opt :title, "The title of the page", :short => "t", :type => :string
      end
      opts
    end

  end
end

