#
#  Panorama.rb
#  PanoList3
#
#  Created by Matthieu DESILE on 9/10/11.
#  Copyright 2011 __MyCompanyName__. All rights reserved.
#

#
class Panorama
    #
    attr_accessor :filename
    #
    attr_accessor :rendering
    #
    def initialize(filename)
        @filename = filename
        @rendering = ""
    end
    
    def name
        return File.basename(@filename)
    end

    def inspect_content filenames
        base = File.basename(@filename, '.pto')
        renderings_regexp = Regexp.new "(#{base}[^[0-9]{4}]*\.(tif|jpg))$", true
        renderings = filenames.select{ |item| item =~ renderings_regexp }
        if renderings.length != 0 then
            @rendering = "#{File.dirname @filename}/#{renderings.first}"
        end
    end
    
    def rendered?
        return (@rendering.length != 0)
    end
    
    def _to_s
        return "Panorama : #{@filename}, #{@rendered}\n"
    end
    
end
