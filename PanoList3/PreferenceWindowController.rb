#
#  PreferenceWindowController.rb
#  PanoList3
#
#  Created by Matthieu DESILE on 11/22/11.
#  Copyright 2011 __MyCompanyName__. All rights reserved.
#

class PreferenceWindowController < NSWindowController
    attr_accessor :defaults
    attr_accessor :sourceField

    def initialize
        @defaults = NSUserDefaults.standardUserDefaults
    end

    def windowNibName
        "PreferenceWindow"
    end
    
    # pragma mark - 
    # pragma mark NSWindow Controller
    def browse sender
        panel = NSOpenPanel.openPanel
        panel.setCanChooseFiles false
        panel.setCanChooseDirectories true
        if panel.runModal == NSOKButton then
            name = panel.directoryURL.path
            sourceField.setStringValue name
        end
    end
    
    def awakeFromNib
        name = NSUserDefaults.standardUserDefaults['source']
        print "name #{name}\n"
        sourceField.setStringValue name if name.length != 0
    end
    
    # pragma mark - 
    # pragma mark NSWindow Delegate
    def windowWillClose sender
        print "window will close\n"
        NSUserDefaults.standardUserDefaults['source'] = sourceField.stringValue
        NSUserDefaults.standardUserDefaults.synchronize
    end
end
