//
//  IssueMenuItem.m
//  GitHubMenubarIssues
//
//  Created by Sergey Klimov on 2/26/12.
//  Copyright (c) 2012 Self-Employed. All rights reserved.
//

#import "IssueMenuItem.h"

@implementation IssueMenuItem
@synthesize issueMenuView=_issueMenuView;

- (id) initWithTitle:(NSString *)aString action:(SEL)aSelector keyEquivalent:(NSString *)charCode {
    if (self=[super initWithTitle:aString action:aSelector keyEquivalent:charCode]) {
        [NSBundle loadNibNamed:@"IssueMenuItem" owner:self];
        self.view =  self.issueMenuView;
    }
    return self;
}
@end
