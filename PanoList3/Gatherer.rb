#
#  Gatherer.rb
#  PanoList3
#
#  Created by Matthieu DESILE on 9/9/11.
#  Copyright 2011 __MyCompanyName__. All rights reserved.
#


require 'find'

class Gatherer
    attr_accessor :path, :groups, :current
    
    def initialize(path)
        @path = path
        @groups = Array.new
    end
    
    def collectAll
        # le match date_regexp n'est pas obligatoire
        date_regexp = Regexp.new "[0-9]{4}/[0-9]{2}/[0-9]{2}$", true
        special_dir_regexp = Regexp.new "(\.|\.\.)$"
        Find.find(@path) do |filename|
            if File.directory?(filename) and date_regexp.match filename then
                #return if special_dir_regexp.match filename 
                Dir.entries(filename).each do |entry|
                    path = "#{filename}/#{entry}"
                    if entry != '.' and entry != '..' and File.directory?(path) then
                        pg = PanoramaGroup.new path
                        pg.collect
                        @groups.push pg
                    end
                end
            end
        end
        @current = @groups
    end
    
    def _to_s
        return "#{@groups.length} groups :\n#{@groups}"
    end
    
    def filterFinalized
        @current = @groups.select{ |item| item.rendered? }
    end
    
    def filterPresent
        @current = @groups.select{ |item| item.assembled? and ! item.rendered? }
    end
    
    def filterNothing
        @current = @groups.select{ |item| (! item.assembled?) and (! item.rendered?) }
    end
    
    def filterAll
        @current = @groups
    end
    
    # IKImageBrowserDatasource - required    
    def imageBrowser(aBrowser, itemAtIndex:  index)
        return @current[index]
    end
    
    def numberOfItemsInImageBrowser(aBrowser)
        NSLog "numberOfItemsInImageBrowser : #{@current.length}"
        return @current.length
    end

    # IKImageBrowserDatasource - optional
    def imageBrowser(aBrowser, groupAtIndex: index)
        return nil
    end

    def imageBrowser(aBrowser, moveItemsAtIndexes: indexes, toIndex:  destinationIndex)
    end
    
    def imageBrowser(aBrowser, removeItemsAtIndexes: indexes)
    
    end
    
    def numberOfGroupsInImageBrowser(aBrowser)
        return 0
    end
    
    
end
