#
#  ImageBrowserView.rb
#  PanoList3
#
#  Created by Matthieu DESILE on 10/2/11.
#  Copyright 2011 __MyCompanyName__. All rights reserved.
#


class ImageBrowserView < IKImageBrowserView
    attr_accessor :item
    
    def awakeFromNib
        self.setAcceptsTouchEvents(true)
        @treshold = 6
    end
    
    def touchesBeganWithEvent(event)
        touches = event.touchesMatchingPhase(NSTouchPhaseTouching, inView: self)
        if touches.count == 2 then
            @initial = touches
            point = self.convertPoint(event.locationInWindow, fromView: nil)
            index = self.indexOfItemAtPoint point
            @item = self.dataSource.imageBrowser(self, itemAtIndex: index)
        end
    end
    
    def touchesMovedWithEvent(event)
        touches = event.touchesMatchingPhase(NSTouchPhaseTouching, inView: self)
        if touches.count == 2 then
            @current = touches
            delta = self.deltaOrigin
            if delta.x.abs >= @treshold then
                unless (@item.nil? or @item.rendered?)
                    @item.render_next (delta.x / @treshold)
                    self.reloadData
                end
            end
        end
    end
    
    def deltaOrigin
        return NSZeroPoint if (@initial.nil? or @current.nil?)
        deviceSize = @initial.allObjects[0].deviceSize
        x1 = [@initial.allObjects[0].normalizedPosition.x, @initial.allObjects[1].normalizedPosition.x].min
        x2 = [@current.allObjects[0].normalizedPosition.x, @current.allObjects[1].normalizedPosition.x].min
        y1 = [@initial.allObjects[0].normalizedPosition.y, @initial.allObjects[1].normalizedPosition.y].min
        y2 = [@current.allObjects[0].normalizedPosition.y, @current.allObjects[1].normalizedPosition.y].min
        delta = NSPoint.new((x2 - x1) * deviceSize.width, (y2 - y1) * deviceSize.height)
    end
    
    
    def magnifyWithEvent(event)
        self.setZoomValue(self.zoomValue + event.magnification)
    end
end
