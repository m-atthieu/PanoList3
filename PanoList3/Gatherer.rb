#
#  Gatherer.rb
#  PanoList3
#
#  Created by Matthieu DESILE on 9/9/11.
#  Copyright 2011 __MyCompanyName__. All rights reserved.
#

require 'find'

class Gatherer
    #
    attr_accessor :path
    # tous les panoramas
    attr_accessor :groups
    # la selection courante
    attr_accessor :current
    attr_accessor :pattern

    #
    def initialize(path)
        @path = path
        @groups = Array.new
        @pattern = nil
    end
    
    #
    def collectAll
        folders = Array.new
        Find.find(@path) do |filename|
            folders << filename
        end
        inspect_folders folders
        @current = @groups
    end

    #
    def inspect_folders folders
        date_regexp = Regexp.new "[0-9]{4}/[0-9]{2}/[0-9]{2}$", true
        folders.each do |filename|
            if File.directory?(filename) and date_regexp.match filename then
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
    end

    def _to_s
        return "#{@groups.length} groups :\n#{@groups}"
    end

    # pragma mark -
    # pragma mark filtering
    # filter = keep => filterFinalized == keep finalized in selection
    #               => unfilterPresent == do not keep present in selection
    def resetFilter
        @current = @groups
        @pattern = nil
    end

    def filterFinalized
        @current = @current + @groups.select{ |item| item.rendered? }
        @current.uniq!
        self.filterName unless @pattern.nil?
    end

    def unfilterFinalized
        @current = @current - @groups.select{ |item| item.rendered? }
        @current.uniq!
        self.filterName unless @pattern.nil?
    end

    def filterPresent
        @current = @current + @groups.select{ |item| item.assembled? and ! item.rendered? }
        @current.uniq!
        self.filterName unless @pattern.nil?
    end

    def unfilterPresent
        @current = @current - @groups.select{ |item| item.assembled? and ! item.rendered? }
        @current.uniq!
        self.filterName unless @pattern.nil?
    end

    def filterNothing
        @current = @current + @groups.select{ |item| (! item.assembled?) and (! item.rendered?) }
        @current.uniq!
        self.filterName unless @pattern.nil?
    end

    def unfilterNothing
        @current = @current - @groups.select{ |item| (not item.assembled?) and (not item.rendered?) }
        @current.uniq!
        self.filterName unless @pattern.nil?
    end

    def filterAll
        @current = @groups
    end

    def unfilterOnName
        re = Regexp.new ".*#{@pattern}.*"
        @current = @current + @groups.select{ |item| not re.match item.path }
        @current.uniq!
    end

    def filterName # pattern
        re = Regexp.new ".*#{@pattern}.*"
        # item.name or item.path
        @current = @current.select{ |item| re.match item.path }
    end

    # pragma mark -
    # pragma mark IKImageBrowserDatasource - required
    def imageBrowser(aBrowser, itemAtIndex:  index)
        return @current[index]
    end

    def numberOfItemsInImageBrowser(aBrowser)
        #NSLog "numberOfItemsInImageBrowser : #{@current.length}"
        return @current.length
    end

    # pragma mark - 
    # pragma mark IKImageBrowserDatasource - optional
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
