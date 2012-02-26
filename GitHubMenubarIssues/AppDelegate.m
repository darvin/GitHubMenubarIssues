//
//  AppDelegate.m
//  GitHubMenubarIssues
//
//  Created by Sergey Klimov on 2/25/12.
//  Copyright (c) 2012 Self-Employed. All rights reserved.
//

#import "AppDelegate.h"
#import "LRAppDefaults.h"
#import "RepoMenuItem.h"
#import "IssueMenuItem.h"
#import "UAGithubEngine+Shared.h"
@implementation AppDelegate

@synthesize window=_window, statusItem = _statusItem, statusMenu = _statusMenu;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    if ([LRAppDefaults isNewInstall]) {
        [LRAppDefaults addAppSetting:@"darvin" withKey:@"githubUser"];
        [LRAppDefaults addAppSetting:@"mustdie" withKey:@"githubPassword"];

    }
}

- (void) awakeFromNib {
    
    self.statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    [self.statusItem setMenu:self.statusMenu];
    [self.statusItem setHighlightMode:YES];
    [self.statusItem setImage:[NSImage imageNamed:@"MenubarIcon.png"]];
    
    [self.statusMenu addItem:[[RepoMenuItem alloc] initWithTitle:@"som" action:nil keyEquivalent:@""]];
    [self.statusMenu addItem:[[IssueMenuItem alloc] initWithTitle:@"som" action:nil keyEquivalent:@""]];
    [self.statusMenu addItem:[[IssueMenuItem alloc] initWithTitle:@"som" action:nil keyEquivalent:@""]];

    [self.statusMenu addItem:[[IssueMenuItem alloc] initWithTitle:@"som" action:nil keyEquivalent:@""]];
    [self.statusMenu addItem:[[RepoMenuItem alloc] initWithTitle:@"som" action:nil keyEquivalent:@""]];
    [self.statusMenu addItem:[[IssueMenuItem alloc] initWithTitle:@"som" action:nil keyEquivalent:@""]];
    
    [[UAGithubEngine shared] repositoriesForUser:@"darvin" includeWatched:NO completion:^id(id result) {
        NSLog(@"%@",result);
        return nil;
    }];
}

@end
