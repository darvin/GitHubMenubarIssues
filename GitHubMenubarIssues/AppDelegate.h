//
//  AppDelegate.h
//  GitHubMenubarIssues
//
//  Created by Sergey Klimov on 2/25/12.
//  Copyright (c) 2012 Self-Employed. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "PrefController.h"
@interface AppDelegate : NSObject <NSApplicationDelegate, PrefControllerDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet NSMenu * statusMenu;
@property (retain) NSStatusItem * statusItem;
@property (nonatomic, retain) NSArray *repos;

- (void) updateIssues;
- (IBAction) openPreferences:(id)sender;
- (void) updateRepos ;
@end
