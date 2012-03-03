//
//  RepoMenuItem.h
//  GitHubMenubarIssues
//
//  Created by Sergey Klimov on 2/26/12.
//  Copyright (c) 2012 Self-Employed. All rights reserved.
//

#import <AppKit/AppKit.h>
#import "Repository.h"
@interface RepoMenuItem : NSMenuItem
@property (assign) IBOutlet NSView* repoMenuView;
@property (assign) IBOutlet NSTextField *titleLabel;

-(id) initWithRepresentedObject:(Repository*) representedObject;
@end
