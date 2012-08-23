#import <Foundation/Foundation.h>

@interface AppDelegate : NSObject
{
    IBOutlet id window;
    IBOutlet id searchField; 
    IBOutlet id countField;
    IBOutlet id browserView;
    IBOutlet id datasource;
    IBOutlet id btnFinished;
    IBOutlet id btnPresent;
    IBOutlet id btnNothing;
    IBOutlet id btnReset;
    IBOutlet id defaults;
}

- (IBAction) refresh: (id) sender;
- (IBAction) openPreferenceWindow: (id) sender;
- (IBAction) toggleFinished: (id) sender;
- (IBAction) togglePresent: (id) sender;
- (IBAction) toggleNothing: (id) sender;
- (IBAction) filterFinalized: (id) sender;
- (IBAction) filterAssembled: (id) sender;
- (IBAction) filterNothingDone: (id) sender;
- (IBAction) filterAll: (id) sender;
- (IBAction) search: (id) sender;

@end
