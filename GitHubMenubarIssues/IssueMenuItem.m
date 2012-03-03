//
//  IssueMenuItem.m
//  GitHubMenubarIssues
//
//  Created by Sergey Klimov on 2/26/12.
//  Copyright (c) 2012 Self-Employed. All rights reserved.
//

#import "IssueMenuItem.h"

@implementation IssueMenuItem
@synthesize issueMenuView=_issueMenuView, titleLabel=_titleLabel, statusButton=_statusButton;

- (id) initWithTitle:(NSString *)aString action:(SEL)aSelector keyEquivalent:(NSString *)charCode {
    if (self=[super initWithTitle:aString action:aSelector keyEquivalent:charCode]) {
        [NSBundle loadNibNamed:@"IssueMenuItem" owner:self];
        self.view =  self.issueMenuView;
        
    }
    return self;
}

- (void) updateViewWithRepresentedObject {
    Issue* issue = self.representedObject;
    self.titleLabel.stringValue = issue.title;
    NSString* statusImageName;
    if (issue.closedByCommit) {
        statusImageName = @"issue-status-closed-by-commit";
    } else if (!issue.open) {
        statusImageName = @"issue-status-reopen";
    } else if (issue.assignedToCurrentUser) {
        statusImageName = @"issue-status-close";
    } else {
        statusImageName = @"issue-status-assign";
    }
    [self.statusButton setImage:[NSImage imageNamed:statusImageName]];
}

-(id) initWithRepresentedObject:(Issue*) representedObject {
    if (self=[self initWithTitle:representedObject.title action:nil keyEquivalent:@""]) {
        self.representedObject = representedObject;
        Issue* issue = representedObject;
        issue.delegate = self;
        [self updateViewWithRepresentedObject];
    }
    return self;
}

-(IBAction)statusButtonClicked:(id)sender {
    Issue* issue = self.representedObject;
    if (!issue.assignedToCurrentUser) {
        [issue assignToCurrentUser];
    } else if (issue.open) {
        [issue close];
        
        
    } else {
        [issue reopen];
    }
}

- (void) issueChanged:(Issue*)issue {
    [self updateViewWithRepresentedObject]; 
}

@end
