//
//  IssueMenuItem.h
//  GitHubMenubarIssues
//
//  Created by Sergey Klimov on 2/26/12.
//  Copyright (c) 2012 Self-Employed. All rights reserved.
//

#import <AppKit/AppKit.h>
#import "Issue.h"
@interface IssueMenuItem : NSMenuItem <IssueDelegate>
@property (assign) IBOutlet NSView* issueMenuView;
@property (assign) IBOutlet NSButton *statusButton;
@property (assign) IBOutlet NSTextField *titleLabel;


-(id) initWithRepresentedObject:(Issue*) representedObject;
-(IBAction)statusButtonClicked:(id)sender;
@end
