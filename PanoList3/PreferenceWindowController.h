//
//  PreferenceWindowController.h
//  PanoList3
//
//  Created by Matthieu DESILE on 11/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface PreferenceWindowController : NSWindowController
@property IBOutlet NSWindow* window;
@property IBOutlet NSTextField* sourceField;

- (IBAction) browse: (id) sender;
@end
