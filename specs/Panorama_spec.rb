#
#  Panorama_spec.rb
#  PanoList3
#
#  Created by Matthieu DESILE on 11/21/11.
#  Copyright 2011 __MyCompanyName__. All rights reserved.
#
require 'PanoList3/Panorama'

describe "Generating a new Panorama" do
    #include Panorama
    it "should return an object of class Panorama" do
        t = Panorama.new "test"
        t.class.should == Panorama
    end
    
    it "should have a name based on filename" do
        t = Panorama.new "2010/10/08/test"
        t.filename.should == "2010/10/08/test"
        t.name.should == "test"
    end

    it "should not be rendered immediatly" do
      t = Panorama.new "2010/10/08/test"
      t.rendered?.should == false
    end
end
