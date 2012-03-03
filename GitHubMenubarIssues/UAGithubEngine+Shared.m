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
        NSString *username = [LRAppDefaults getAppSettingWithKey:@"githubUsername"];
        NSString *password = [LRAppDefaults getAppSettingWithKey:@"githubPassword"];
        if (!shared&&!([shared.username isEqualToString:username]&&[shared.password isEqualToString:password]))
            shared = [[UAGithubEngine alloc] initWithUsername:username password:password withReachability:YES];
        
        return shared;
    }
}

+(NSString*) currentUser {
    return [LRAppDefaults getAppSettingWithKey:@"githubUsername"];
}
@end
