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
        @t.class.should.equal Gatherer
    end

    it "should have an empty group array" do
        @t.groups.length.should.equal 0
    end
end
