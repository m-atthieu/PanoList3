#
#  AppDelegate.rb
#  PanoList3
#
#  Created by Matthieu DESILE on 9/9/11.
#  Copyright 2011 __MyCompanyName__. All rights reserved.
#

class AppDelegate
    attr_accessor :window, :searchField, :countField, :browserView, :datasource
    
    def applicationDidFinishLaunching(a_notification)
        # Insert code here to initialize your application
    end
    
    def refreshDataSource(path)
        @datasource = Gatherer.new path
        @datasource.collectAll
        
        @browserView.setDataSource(@datasource)
        self.reloadData
    end
    
    def refresh(sender)
        self.refreshDataSource "/Volumes/Users/furai/Powo/pano"
        NSLog g.inspect
    end
    
    def awakeFromNib
        @browserView.setCellsStyleMask(IKCellsStyleTitled | IKCellsStyleSubtitled | IKCellsStyleShadowed)
        self.refreshDataSource "/Volumes/Users/furai/Powo/pano"
    end
    
    # filters
    def filterFinalized sender
        @datasource.filterFinalized
        self.reloadData
    end
    
    def filterAssembled(sender)
        @datasource.filterPresent
        self.reloadData
    end
    
    def filterNothingDone(sender)
        @datasource.filterNothing
        self.reloadData
    end
    
    def filterAll(sender)
        @datasource.filterAll
        self.reloadData
    end
    
    def search(sender)
        if(@searchField.stringValue.length != 0) then
            @datasource.filterName @searchField.stringValue
            self.reloadData
            NSLog("searching : #{@searchField.stringValue}")
        else
            @datasource.resetFilter
            self.reloadData
        end
    end
    
    def reloadData
        n = @datasource.numberOfItemsInImageBrowser @browserView
        @countField.setStringValue "#{n} panoramas"
        @browserView.reloadData
    end
    
    # IKImageBrowserDelegate
    def imageBrowser(aBrowser, backgroundWasRightClickedWithEvent: anEvent)
        NSLog "background right clicked"
    end
end

