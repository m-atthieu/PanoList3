#
#  AppDelegate.rb
#  PanoList3
#
#  Created by Matthieu DESILE on 9/9/11.
#  Copyright 2011 __MyCompanyName__. All rights reserved.
#

class AppDelegate < NSObject
    attr_accessor :window, :searchField, :countField, :browserView, :datasource
    attr_accessor :btnFinished, :btnPresent, :btnNothing, :btnReset
    attr_accessor :defaults
    
    def initialize
        # puts "initialize"
        defaults = { 'source' => File.join(ENV['HOME'], 'Pictures') }
        NSUserDefaults.standardUserDefaults.registerDefaults defaults
    end

    def applicationDidFinishLaunching(a_notification)
        # Insert code here to initialize your application
        @defaults = NSUserDefaults.standardUserDefaults
        print @defaults
    end
    
    def applicationShouldTerminateAfterLastWindowClosed(theApplication)
        true
    end
    
    def refreshDataSource(path)
        @datasource = Gatherer.new path
        @datasource.collectAll
        
        @browserView.setDataSource(@datasource)
        self.reloadData
    end
    
    def refresh(sender)
        source = NSUserDefaults.standardUserDefaults['source']
        self.refreshDataSource source if source.length != 0
    end
    
    def awakeFromNib
        @browserView.setCellsStyleMask(IKCellsStyleTitled | IKCellsStyleSubtitled | IKCellsStyleShadowed)
        source = NSUserDefaults.standardUserDefaults['source']
        self.refreshDataSource source if source.length != 0
    end
    
    def openPreferenceWindow sender
        PreferenceWindowController.alloc.init.showWindow self
    end
    
    # filter buttons
    def toggleFinished(sender)
        if @btnFinished.state == NSOffState then
            @datasource.unfilterFinalized
            NSLog "remove finalized"
        else
            @datasource.filterFinalized
            NSLog "add finalized"
        end
        self.reloadData
    end

    def togglePresent sender
        NSLog "toggle present #{@btnPresent.state}"
        if @btnPresent.state == NSOffState then
            @datasource.unfilterPresent
        else
            @datasource.filterPresent
        end
        self.reloadData
    end

    def toggleNothing sender
        NSLog "toggle nothing #{@btnNothing.state}"
        if @btnNothing.state == NSOffState then
            @datasource.unfilterNothing
        else
            @datasource.filterNothing
        end
        self.reloadData
    end

    # filters
    def filterFinalized(sender)
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
        @btnFinished.setState NSStateOn
        @btnPresent.setState NSStateOn
        @btnNothing.setState NSStateOn
        @searchField.setStringValue ''
        self.reloadData
    end
    
    def search(sender)
        if(@searchField.stringValue.length != 0) then
            @datasource.pattern = @searchField.stringValue
            @datasource.filterName
            self.reloadData
            #NSLog("searching : #{@searchField.stringValue}")
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

