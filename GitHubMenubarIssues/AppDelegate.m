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
#import "Repository.h"
#import "Issue.h"
#import "PrefController.h"

@implementation AppDelegate

@synthesize window=_window, 
statusItem = _statusItem, 
statusMenu = _statusMenu,
repos=_repos;




- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    if ([LRAppDefaults isNewInstall]||![[NSKeyedUnarchiver unarchiveObjectWithData:[LRAppDefaults getAppSettingWithKey:@"monitoredRepos"]] count]) {
        [self openPreferences:self];
    }
    
    [self updateRepos];

}


- (NSArray*) filterReposInMenu {
    NSMutableArray *result = [NSMutableArray array];
    for (Repository *repo in self.repos) {
        if (repo.showInMenu)
            [result addObject:repo];
    }
    return [NSArray arrayWithArray:result];
}

- (void) setRepos:(NSArray *)repos {
    _repos = repos;
    [self updateIssues];

}

- (void) updateIssues {
    for (Repository* repository in [self filterReposInMenu]) {
        [repository fetchIssues];
        
        
        [self.statusMenu addItem:[[RepoMenuItem alloc] initWithRepresentedObject:repository]];
        
        
        
        for (Issue *issue in repository.issues) {
            if (issue.open&&((!issue.assignee)||issue.assignedToCurrentUser))
                [self.statusMenu addItem:[[IssueMenuItem alloc] initWithRepresentedObject:issue]];
        }
    }
}

- (void) updateRepos {
    NSArray *repos = [NSKeyedUnarchiver unarchiveObjectWithData:[LRAppDefaults getAppSettingWithKey:@"monitoredRepos"]];
    self.repos = repos;

}

- (void) awakeFromNib {
    
    self.statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    [self.statusItem setMenu:self.statusMenu];
    [self.statusItem setHighlightMode:YES];
    [self.statusItem setImage:[NSImage imageNamed:@"MenubarIcon.png"]];
    
    
}



- (IBAction) openPreferences:(id)sender {
    [PrefController sharedPrefController].delegate = self;
    [[PrefController sharedPrefController] showWindow:self];
    [[[PrefController sharedPrefController] window] orderFrontRegardless];
    
    
}

-(void) prefControllerClosed:(PrefController *)prefController {
    
}


@end
