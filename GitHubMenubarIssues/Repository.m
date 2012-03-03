//
//  Repository.m
//  GitHubMenubarIssues
//
//  Created by Sergey Klimov on 3/3/12.
//  Copyright (c) 2012 Self-Employed. All rights reserved.
//

#import "Repository.h"
#import "UAGithubEngine+Shared.h"
#import "Issue.h"
#import "Taskit.h"
@implementation Repository
@synthesize name=_name, path=_path, issues=_issues,
                showInMenu=_showInMenu, closeByCommit=_closeByCommit;

-(id) initWithName:(NSString*)name{
    if (self=[super init]) {
        _name = name;
        _issues = [NSMutableArray array];
    }
    return self;
}


- (id)initWithCoder:(NSCoder *)decoder {
    if (self=[self initWithName:[decoder decodeObjectForKey:@"RepositoryName"]]) {
        _path = [decoder decodeObjectForKey:@"RepositoryPath"];
        self.showInMenu = [decoder decodeBoolForKey:@"RepositoryShowInMenu"];
        self.closeByCommit = [decoder decodeBoolForKey:@"RepositoryCloseByCommit"];

    }
    return self;
}


- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.path forKey:@"RepositoryPath"];
    [encoder encodeObject:self.name forKey:@"RepositoryName"];
    [encoder encodeBool:self.closeByCommit forKey:@"RepositoryCloseByCommit"];
    [encoder encodeBool:self.showInMenu forKey:@"RepositoryShowInMenu"];
    
}

- (NSString*) description {
    return [NSString stringWithFormat:@"Repo %@ at %@", self.name, self.path];
}

- (BOOL) closeByCommit {
    if (self.path) {
        return _closeByCommit;
    }
    return NO;
}

- (void) setCloseByCommit:(BOOL)closeByCommit {
    if (self.path) {
        _closeByCommit = closeByCommit;
    }
}

- (void) fetchIssues {
    [[UAGithubEngine shared] issuesForRepository:self.name withParameters:nil requestType:UAGithubIssuesOpenRequest completion:^id(id newIssuesForRepo) {
        if (![newIssuesForRepo isKindOfClass:[NSError class]])
            for (NSDictionary* issue in newIssuesForRepo) {
                [self.issues addObject:[[Issue alloc] initWithDictionary:issue andRepository:self]];
            }
        
        return nil;
    }];
}


- (void) commitWithIssue:(Issue *)issue {
    Taskit *task = [Taskit task];
    task.launchPath = @"/usr/bin/git";
    task.workingDirectory = [self.path absoluteString];
    [task.arguments addObject:@"commit"];
    [task.arguments addObject:@"-a"];
    [task.arguments addObject:@"-m"];
    [task.arguments addObject:[issue commitMessage]];

    [task populateWithCurrentEnvironment];
    task.receivedOutputString = ^void(NSString *output) {
        NSLog(@"%@", output);
        if ([output rangeOfString:@"nothing to commit"].location == NSNotFound) { //FIXME! we should test exit code instead stupid string parsing
            issue.closedByCommit = YES;
        }
    };
    
    
    [task launch];
}


+(void) fetchReposForCurrentUserCompletion:(id(^)(NSArray * repos))successBlock_ {
    [[UAGithubEngine shared] repositoriesWithCompletion:^id(id repos) {
        if ([repos isKindOfClass:[NSError class]]) {
            return nil;
        }
        NSMutableArray *newRepos = [NSMutableArray arrayWithCapacity:[repos count]];
        for (NSDictionary *repo in repos) {
            NSString *name = [NSString stringWithFormat:@"%@/%@", [[repo objectForKey:@"owner"] objectForKey:@"login"], [repo objectForKey:@"name"]];
            Repository *newRepo = [[Repository alloc] initWithName:name];
            [newRepos addObject:newRepo];
        }
        successBlock_([NSArray arrayWithArray:newRepos]);
        return nil;
    }];
}
@end
