# encoding: utf-8
require 'trollop'
require 'rainbow'
require 'docface/version'

module DocFace
  class Cli

    def opts
      DocFace::Cli.opts
    end

    def self.opts
      p = Trollop::Parser.new do
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

          Example Usage: docface -d ~/git/chef/cookbooks ~/git/chef/site-cookbooks  -o ~/my_build
          For help use: docface --help
        EOS
        opt :dir, "The directories to scan for markdown files. For multiple directories, separate each directory with a space.", :short => "d", :type => :strings, :required => true
        opt :output, "The directory to write the generated output to", :short => "o", :type => :string
        opt :title, "The title of the page", :short => "t", :type => :string
        opt :summary, "A custom summary for the page", :short => "s", :type => :string
        opt :wide, "Pass this parameter if you need a wider nav", :short => "w"
        opt :verbose, "Verbose CLI output", :short => "v"
      end

      opts = Trollop::with_standard_exception_handling p do
        raise Trollop::HelpNeeded if ARGV.empty? # show help screen
        p.parse ARGV
      end
    end

  end
end

