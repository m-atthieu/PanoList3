#
#  AppDelegate.rb
#  PanoList3
#
#  Created by Matthieu DESILE on 9/9/11.
#  Copyright 2011 __MyCompanyName__. All rights reserved.
#

class AppDelegate
    attr_accessor :window, :browserView
    
    def applicationDidFinishLaunching(a_notification)
        # Insert code here to initialize your application
    end
    
    def refreshDataSource(path)
        g = Gatherer.new path
        g.collectAll
        @browserView.setDataSource(g)
        @browserView.reloadData
    end
    
    def refresh(sender)
        self.refreshDataSource "/Volumes/Users/furai/Powo/pano"
        NSLog g.inspect
    end
    
    def awakeFromNib
        @browserView.setCellsStyleMask(IKCellsStyleTitled | IKCellsStyleSubtitled | IKCellsStyleShadowed)
        self.refreshDataSource "/Volumes/Users/furai/Powo/pano"
    end
    
    # IKImageBrowserDelegate
    def imageBrowser(aBrowser, backgroundWasRightClickedWithEvent: anEvent)
        NSLog "background right clicked"
    end
end

