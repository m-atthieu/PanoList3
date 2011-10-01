#
#  Panorama.rb
#  PanoList3
#
#  Created by Matthieu DESILE on 9/10/11.
#  Copyright 2011 __MyCompanyName__. All rights reserved.
#


class Panorama
    attr_accessor :filename, :rendering
    
    def initialize(filename)
        @filename = filename
        @rendering = ""
    end
    
    def name
        return File.basename(@filename)
    end
    
    def rendered?
        return (@rendering.length != 0)
    end
    
    def _to_s
        return "Panorama : #{@filename}, #{@rendered}\n"
    end
    
end