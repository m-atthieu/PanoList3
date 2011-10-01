#
#  PanoramaGroup.rb
#  PanoList3
#
#  Created by Matthieu DESILE on 9/10/11.
#  Copyright 2011 __MyCompanyName__. All rights reserved.
#

class PanoramaGroup
    attr_accessor :path, :panoramas, :rendering
    
    def initialize(path)
        @path = path
        @panoramas = Array.new
        @rendering = ""
    end
    
    def rendered?
        r = false
        @panoramas.each { |item| r = (r or item.rendered?) }
        #print "r #{r}\n"
        return (@rendering.length != 0  or r)
    end
    
    def assembled?
        return (@panoramas.length != 0)
    end
    
    def name
        return File.basename(@path)
    end
    
    def collect
        basename = File.basename(@path)
        pto_regexp = Regexp.new "(.*)\.pto$", true
        final_regexp = Regexp.new "(#{basename}[^0-9]+.*\.(tif|jpg))$", true
        entries = Dir.entries(path)
        entries.each do |entry|
            # on regarde s'il y a des pto
            if pto_regexp.match entry then
                base = Regexp.last_match[1]
                p = Panorama.new("#{path}/#{entry}")
                
                re = Regexp.new "(#{base}.*\.(tif|jpg))$", true
                entries.each do |entry|
                    if re.match entry then
                        p.rendering = "#{@path}/#{Regexp.last_match[1]}"
                    end
                end
                @panoramas.push p
            end
            # on regarde s'il y a un pano finalise
            if final_regexp.match entry then
                @rendering = "#{@path}/#{Regexp.last_match[1]}"
            end
        end
        # on vérifie qu'un rendering ne nous a pas echappé
        if @rendering.length == 0 then
            #@panoramas.each { |item| if item.rendered? then @rendering = item.rendering }
            rendereds = @panoramas.select{ |item| item.rendered? }
            if rendereds.length != 0 then @rendering = rendereds.first.rendering end
        end
        # s'il n'y en a pas => nothing_done
    end
    
    
    # IKImageBrowserItem - required
    def imageRepresentation
        #NSLog @rendering
        @rendering
    end
    
    def imageRepresentationType
        IKImageBrowserPathRepresentationType
    end

    def imageUID
        @path
    end
    
    # IKImageBrowserItem - optional
    def imageSubtitle
        r = "x"
        if self.assembled? then r = "~" end
        if self.rendered? then r = "o" end
        date = Regexp.new("([0-9]{4}/[0-9]{2}/[0-9]{2})").match(@path)[1]
        return "#{r} - #{date}"
    end
    
    def imageTitle
        File.basename(@path)
    end
    
end