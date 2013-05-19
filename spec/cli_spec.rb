require File.dirname(__FILE__) + '/../lib/docface/cli.rb'
require File.dirname(__FILE__) + '/helpers.rb'

describe 'DocFace::Cli' do
  include Helpers

  before(:each) do
    ARGV.clear
  end

  describe 'cli commands' do
    it 'should return help with no ARGVs' do
      lambda { DocFace::Cli.opts }.should raise_error SystemExit
    end

    it 'should return directory' do
      ARGV.push("-d", "~/test")
      response = DocFace::Cli.opts
      response.should eq({:dir=>["~/test"], :output=>nil, :title=>nil, :description=>nil, :version=>false, :help=>false, :dir_given=>true})
    end

    it 'should return all options' do
      ARGV.push("-d", "~/test", "-o", "~/my_output", "-t", "something", "-D", "some random description")
      response = DocFace::Cli.opts
      response.should eq({:dir=>["~/test"], :output=>"~/my_output", :title=>"something", :description=>"some random description", :version=>false, :help=>false, :dir_given=>true, :output_given=>true, :title_given=>true, :description_given=>true})
    end
  end
end
