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
        t.class.should.equal Panorama
    end
    
    it "should have a filename" do
        t = Panorama.new "test"
        t.filename.should.equal "test"
    end
end
