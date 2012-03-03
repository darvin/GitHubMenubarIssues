//
//  RepoMenuItem.m
//  GitHubMenubarIssues
//
//  Created by Sergey Klimov on 2/26/12.
//  Copyright (c) 2012 Self-Employed. All rights reserved.
//

#import "RepoMenuItem.h"
#import "Repository.h"
@implementation RepoMenuItem
@synthesize repoMenuView=_repoMenuView, titleLabel=_titleLabel;

- (id) initWithTitle:(NSString *)aString action:(SEL)aSelector keyEquivalent:(NSString *)charCode {
    if (self=[super initWithTitle:aString action:aSelector keyEquivalent:charCode]) {
        [NSBundle loadNibNamed:@"RepoMenuItem" owner:self];
        self.view =  self.repoMenuView;
    }
    return self;
}


-(id) initWithRepresentedObject:(Repository*) representedObject {
    if (self=[self initWithTitle:representedObject.name action:nil keyEquivalent:@""]) {
        self.representedObject = representedObject;
        [self.titleLabel setStringValue:representedObject.name];
    }
    return self;
}

@end
