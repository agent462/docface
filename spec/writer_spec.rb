require File.dirname(__FILE__) + '/../lib/docface/writer.rb'
require File.dirname(__FILE__) + '/helpers.rb'
require 'digest/md5'

describe 'DocFace::Writer' do
  include Helpers

  before do
    @writer = DocFace::Writer.new
  end

  it 'should see if a directory exists' do
    response = @writer.dir_exists?(File.join(File.dirname(__FILE__),'./files'))
    response.should == true
  end

  it 'should write a file' do
    file = "/tmp/docface/spec.txt"
    @writer.write("/tmp/docface",file,"This is the content")
    md5 = Digest::MD5.hexdigest(File.read("/tmp/docface/spec.txt"))
    md5.should == "75fca8d37b0f7d75d11ccc8d255debe5"
    File.delete(file)
  end

  it 'can move assets' do
    @writer.assets(File.join(File.dirname(__FILE__),'./files'),"/tmp/docface/stuff")
    File.exists?("/tmp/docface/stuff/README.md").should == true
    File.exists?("/tmp/docface/stuff/CHANGELOG.md").should == true
    FileUtils.rm_r("/tmp/docface/stuff")
  end
end
