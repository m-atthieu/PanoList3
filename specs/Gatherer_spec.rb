#
#  Gatherer_spec.rb
#  PanoList3
#
#  Created by Matthieu DESILE on 11/21/11.
#  Copyright 2011 __MyCompanyName__. All rights reserved.
#
require 'fakefs/spec_helpers'

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
