#
#  Gatherer_spec.rb
#  PanoList3
#
#  Created by Matthieu DESILE on 11/21/11.
#  Copyright 2011 __MyCompanyName__. All rights reserved.
#
require 'PanoList3/Gatherer'

describe "Generating a new Gatherer" do
    it "should return an object of class Gatherer" do
        t = Gatherer.new ""
        t.class.should.equal Gatherer
    end
end
