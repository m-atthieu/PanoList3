//
//  AppDelegate.h
//  PanoList3
//
//  Created by Matthieu DESILE on 9/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Quartz/Quartz.h>

@interface AppDelegate : NSObject

@property IBOutlet NSWindow* window;
@property IBOutlet IKImageBrowserView* browserView;

- (IBAction) refresh: (id) sender;

@end
