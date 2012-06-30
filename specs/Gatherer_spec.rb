#
#  Gatherer_spec.rb
#  PanoList3
#
#  Created by Matthieu DESILE on 11/21/11.
#  Copyright 2011 __MyCompanyName__. All rights reserved.
#
require 'PanoList3/Gatherer'

describe "Generating a new Gatherer" do
    before do
        @t = Gatherer.new ""
    end
    
    it "should return an object of class Gatherer" do
        @t.class.should == Gatherer
    end

    it "should have an empty group array" do
        @t.groups.length.should == 0
    end
end

describe "Gatherer parsed 2 directories" do
    before do
        @t = Gatherer.new "/Volumes/Users/furai/Powo/pano"
        FakeFS.activate! 
        FakeFS::FileSystem.clear
        FileUtils.mkdir_p('/Volumes/Users/furai/Powo/pano/2010/02/28/ski')
        FileUtils.mkdir_p('/Volumes/Users/furai/Powo/pano/2010/02/29/campagne')
        @t.collectAll
    end

    it "should have 2 groups" do
        @t.groups.length.should == 2
    end

    after do
        FakeFS.deactivate!
    end
end

describe "Gatherer parsed auray directory" do
    before do
        @t = Gatherer.new "/Volumes/Users/furai/Powo/pano"
        FakeFS.activate!
        FakeFS::FileSystem.clear
        FakeFS::read_filesystem File.expand_path(File.dirname(__FILE__) + "/auray.fs.test")
        @t.collectAll
    end
        
    it "should have one group with one panorama" do
    	@t.groups.length.should == 1
        @t.groups[0].panoramas.length.should == 1
    end
    
    it "should be rendered" do
        @t.groups[0].rendered?.should == true
    end
    
    after do
        FakeFS.deactivate!
    end
end

describe "Gatherer parsed quiraing directory" do
    before do
        @t = Gatherer.new "/Volumes/Users/furai/Powo/pano"
        FakeFS.activate!
        FakeFS::FileSystem.clear
        FakeFS::read_filesystem File.expand_path(File.dirname(__FILE__) + "/quiraing.fs.test")
        @t.collectAll
    end

    it "should have one group with two panoramas" do
        @t.groups.length.should == 1
        @t.groups[0].panoramas.length.should == 2
    end

    it "should be rendered" do
        @t.groups[0].rendered?.should == true
    end

    after do
        FakeFS.deactivate!
    end
end

describe "Gatherer parsed tour-eiffel-08 directory" do
    before do
        @t = Gatherer.new "/Volumes/Users/furai/Powo/pano"
        FakeFS.activate!
        FakeFS::FileSystem.clear
        FakeFS::read_filesystem File.expand_path(File.dirname(__FILE__) + "/tour08.fs.test")
        @t.collectAll
    end

    it "should have one group with two panoramas" do
        @t.groups.length.should == 1
        @t.groups[0].panoramas.length.should == 2
    end

    it "should not be rendered" do
        @t.groups[0].rendered?.should == false
    end

    it "should be assembled" do
        @t.groups[0].assembled?.should == true
    end

    after do
        FakeFS.deactivate!
    end
end
