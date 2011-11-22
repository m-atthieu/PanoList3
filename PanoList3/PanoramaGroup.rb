# -*- coding: iso-8859-1 -*-
#
#  PanoramaGroup.rb
#  PanoList3
#
#  Created by Matthieu DESILE on 9/10/11.
#  Copyright 2011 __MyCompanyName__. All rights reserved.
#

# this class represents a folder containing panoramas
# 
# 
class PanoramaGroup
    # the path to the panorama group
    attr_accessor :path
    # the panoramas that are contained in this group
    attr_accessor :panoramas
    # a filename or a list of filename for the rendering of this panorama
    attr_accessor :rendering
    # the current rendering used
    attr_accessor :index
    # a list of images in this group
    attr_accessor :images
    # the current version (IK)
    attr_accessor :version
    
    # 
    def initialize(path)
        @path = path
        @panoramas = Array.new
        @rendering = ""
        @version = 0
    end
    
    #
    def rendered?
        r = false
        @panoramas.each { |item| r = (r or item.rendered?) }
        return (@rendering.length != 0 or r)
    end
    
    #
    def render_next step
        @index = 0 if @index.nil?
        @index = (@index + 1).modulo(@images.length).to_i
        @version += 1
        NSLog "index : #{@index}"
    end

    #
    def assembled?
        return (@panoramas.length != 0)
    end
    
    #
    def name
        return File.basename(@path)
    end
    
    #
    def collect
        entries = Dir.entries(@path)
        inspect_content entries
        analyse_inspect
    end
    
    # 
    def inspect_content filenames
        basename = File.basename(@path)
        pto_regexp = Regexp.new "(.*)\.pto$", true
        final_regexp = Regexp.new "(#{basename}[^0-9]+.*\.(tif|jpg))$", true
        filenames.each do |entry|
            # on regarde s'il y a des pto
            if pto_regexp.match entry then
                base = Regexp.last_match[1]
                p = Panorama.new("#{path}/#{entry}")
                
                re = Regexp.new "(#{base}.*\.(tif|jpg))$", true
                filenames.each do |entry|
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
    end
    
    def analyse_inspect
        # on v??rifie qu'un rendering ne nous a pas echapp??
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
        # if there is no rendering, first image ?
        unless self.rendered?
            if @images.nil? then
              re = Regexp.new ".*\.(jpe?g|nef|tiff?|rw2)$", true
              @images = Dir.entries(@path).select{ |item| re.match item }
                @images.map!{ |item| @path + '/' + item }
            end
            @index = 0 if @index.nil?
            #p @index
            return @images[@index]
        end
        @rendering
    end
    
    def imageRepresentationType
        IKImageBrowserPathRepresentationType
    end

    def imageUID
        @path
    end
    
    def imageVersion
        @version
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
