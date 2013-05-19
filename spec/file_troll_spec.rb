require File.dirname(__FILE__) + '/../lib/docface/file_troll.rb'
require File.dirname(__FILE__) + '/helpers.rb'

describe 'DocFace::FileTroll' do
  include Helpers

  before do
    @troll = DocFace::FileTroll.new
  end

  it 'should troll a directory' do
    response = @troll.troll(File.join(File.dirname(__FILE__),'./files'))
    response.should == ["/Users/bryan/git/DocFace/spec/./files/CHANGELOG.md", "/Users/bryan/git/DocFace/spec/./files/README.md"]
  end

  it 'should fail on a directory that does not exist' do
    lambda { @troll.troll('somerandomdirectory/') }.should raise_error SystemExit
  end

  it 'should return index hash' do
    list = @troll.troll(File.join(File.dirname(__FILE__),'./files'))
    response = @troll.index_hash(list)
    response.should == {""=>{"Users"=>{"bryan"=>{"git"=>{"DocFace"=>{"spec"=>{"."=>{"files"=>{"CHANGELOG.md"=>{}, "README.md"=>{}}}}}}}}}} #This needs to change so it doesn't fail on a different machine
  end
end
