//
//  PrefController.m
//  GitHubMenubarIssues
//
//  Created by Sergey Klimov on 3/3/12.
//  Copyright (c) 2012 Self-Employed. All rights reserved.
//

#import "PrefController.h"
#import "AppDelegate.h"
#import "LRAppDefaults.h"
#import "Repository.h"
@implementation PrefController

@synthesize delegate, createRepoName=_createRepoName, repoArrayController=_repoArrayController;

- (id) initWithWindowNibName:(NSString *)windowNibName {
    if (self=[super initWithWindowNibName:windowNibName]){
        self.window.delegate = self;
    }
return self;
}




+(PrefController*) sharedPrefController {
static PrefController* prefs = nil;
if (!prefs)
{
    prefs = [[PrefController alloc] initWithWindowNibName:@"PrefController"];
}
return prefs;
}



-(void)windowWillClose:(NSNotification *)notification {
[self.delegate prefControllerClosed:self];
}

- (NSArray *) repos {
     AppDelegate* __weak appDelegate = [[NSApplication sharedApplication] delegate];
    return appDelegate.repos;
}
- (void) setRepos:(NSArray *)repos {
    AppDelegate* appDelegate = [[NSApplication sharedApplication] delegate];
    appDelegate.repos = repos;
}

- (void) setUsername:(NSString *)username {
    [LRAppDefaults updateAppSetting:username withKey:@"githubUsername"];
}

- (void) setPassword:(NSString *)password {
    [LRAppDefaults updateAppSetting:password withKey:@"githubPassword"];
}

- (NSString*) username {
    return [LRAppDefaults getAppSettingWithKey:@"githubUsername"];
}

- (NSString*) password {
    return [LRAppDefaults getAppSettingWithKey:@"githubPassword"];
}

- (IBAction)syncRepoList:(id)sender {
    [Repository fetchReposForCurrentUserCompletion:^id(NSArray *repos) {
        NSMutableArray *newRepos = [NSMutableArray arrayWithArray:repos];
        for (Repository* newRepo in repos) {
            for (Repository* oldRepo in self.repos) {
                if ([newRepo.name isEqualToString:oldRepo.name]) {
                    [newRepos removeObject:newRepo];
                }
            }
        }
        [newRepos addObjectsFromArray:self.repos];
        self.repos = [NSArray arrayWithArray:newRepos];
        return nil;
    } ];
}

-(IBAction)saveRepoList:(id)sender {
    
    [LRAppDefaults updateAppSetting:[NSKeyedArchiver archivedDataWithRootObject:self.repos]
                         withKey:@"monitoredRepos"];

}

-(IBAction)addNewRepo:(id)sender {
    Repository *newRepo = [[Repository alloc] initWithName:self.createRepoName.stringValue];
    NSMutableArray *newRepos = [NSMutableArray arrayWithArray:self.repos];
    [newRepos addObject: newRepo];
    self.repos = [NSArray arrayWithArray:newRepos];
}

-(IBAction)deleteRepo:(id)sender {
    [self.repoArrayController remove:self];
}

@end
