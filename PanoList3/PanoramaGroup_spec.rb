#
#  PanoramaGroup_spec.rb
#  PanoList3
#
#  Created by Matthieu DESILE on 11/22/11.
#  Copyright 2011 __MyCompanyName__. All rights reserved.
#
require 'PanoList3/PanoramaGroup'

describe "Generating a new PanoramaGroup" do
    before do
        @t = PanoramaGroup.new "2010/10/21/tour-eiffel"
    end
    
    it "should return an object of class PanoramaGroup" do
        @t.class.should.equal PanoramaGroup
    end
    
    it "should have an empty panorama list" do
        @t.panoramas.length.should.equal 0
    end
    
    it "should not be rendered" do
        @t.rendering.should.equal ""
        @t.rendered?.should.be.false
    end

    it "should have a name based on filename" do
        @t.name.should.equal "tour-eiffel"
    end
end

describe "PanoramaGroup with a rendered panorama with the same name" do
    before do
        @t = PanoramaGroup.new "2010/10/21/tour-eiffel"
        @t.inspect_content [ 'tour-eiffel.pto', 'img01.jpg', 'img02.jpg', 'tour-eiffel.jpg' ]
        @t.analyse_inspect
    end
    
    it "should have a rendering" do
        @t.rendered?.should.be.true
        @t.rendering.should.equal "2010/10/21/tour-eiffel/tour-eiffel.jpg"
    end
end

describe "PanoramaGroup with a rendered panorama having a different name" do
    before do
        @t = PanoramaGroup.new "2010/10/21/tour-eiffel"
        @t.inspect_content [ 'tour-eiffel-cl.pto', 'img01.jpg', 'img02.jpg', 'tour-eiffel-cl.jpg' ]
        @t.analyse_inspect
    end

    it "should have a rendering" do
        @t.rendered?.should.be.true
        @t.rendering.should.equal "2010/10/21/tour-eiffel/tour-eiffel-cl.jpg"
    end
end

describe "PanoramaGroup with a rendered panorama having a completly different name" do
    before do
        @t = PanoramaGroup.new "2010/10/21/tour-eiffel"
        @t.inspect_content [ 'img-01-02.pto', 'img01.jpg', 'img02.jpg', 'img-01-02.jpg' ]
        @t.analyse_inspect
    end

    it "should have a rendering" do
        @t.rendered?.should.be.true
        @t.rendering.should.equal "2010/10/21/tour-eiffel/img-01-02.jpg"
    end
end

describe "PanoramaGroup without a rendering but with an assembly" do
    before do
        @t = PanoramaGroup.new "2010/10/21/tour-eiffel"
        @t.inspect_content [ 'tour-eiffel-cl.pto', 'img01.jpg', 'img02.jpg' ]
        @t.analyse_inspect
    end

    it "should not be rendered" do
        @t.rendered?.should.be.false
    end

    it "should have an image rendered" do
        @t.rendering.nil?.should.be.false
    end

    it "should be assembled" do
        @t.assembled?.should.be.true
    end
end

describe "PanoramaGroup without rendering without assembly" do
    before do
        @t = PanoramaGroup.new "2010/10/21/tour-eiffel"
        @t.inspect_content [ 'img01.jpg', 'img02.jpg' ]
        @t.analyse_inspect
    end

    it "should not be rendered" do
        @t.rendered?.should.be.false
    end

    it "should have an image rendered" do
        @t.rendering.nil?.should.be.false
    end

    it "should not be assembled" do
        @t.assembled?.should.be.false
    end
end
