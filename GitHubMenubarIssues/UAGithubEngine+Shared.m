//
//  UAGithubEngine+Shared.m
//  GitHubMenubarIssues
//
//  Created by Sergey Klimov on 2/26/12.
//  Copyright (c) 2012 Self-Employed. All rights reserved.
//

#import "UAGithubEngine+Shared.h"
#import "LRAppDefaults.h"
@implementation UAGithubEngine (Shared)
+(UAGithubEngine *) shared {
    static UAGithubEngine *shared;
    
    @synchronized(self)
    {
        if (!shared)
            shared = [[UAGithubEngine alloc] initWithUsername:[LRAppDefaults getAppSettingWithKey:@"githubUsername"] password:[LRAppDefaults getAppSettingWithKey:@"githubPassword"] withReachability:YES];
        
        return shared;
    }
}

@end
