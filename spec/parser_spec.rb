require File.dirname(__FILE__) + '/../lib/docface/parser.rb'
require File.dirname(__FILE__) + '/helpers.rb'
require 'digest/md5'

describe 'DocFace::Writer' do
  include Helpers

  before do
    @parser = DocFace::Parser.new
  end

  it 'should parse a file to html' do
    file = File.join(File.dirname(__FILE__),'./files/README.md')
    md5 =  Digest::MD5.hexdigest(@parser.to_html(file))
    md5.should == "a80c22619023428359af85dd10bbf2cc"
  end

  it 'should parse a file to latex' do
    file = File.join(File.dirname(__FILE__),'./files/README.md')
    md5 =  Digest::MD5.hexdigest(@parser.to_latex(file))
    md5.should == "ab3c210202731eb87dfb1d53206a662f"
  end

end
