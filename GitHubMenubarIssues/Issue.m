//
//  Issue.m
//  GitHubMenubarIssues
//
//  Created by Sergey Klimov on 3/3/12.
//  Copyright (c) 2012 Self-Employed. All rights reserved.
//

#import "Issue.h"
#import "UAGithubEngine+Shared.h"
@implementation Issue

@synthesize closedByCommit=_closedByCommit, delegate=_delegate, repository=_repository;

-(id) initWithDictionary:(NSDictionary*)issueDictionary andRepository:(Repository*)repository {
    self = [super init];
    if (self) {
        _dict = issueDictionary;
        _repository = repository;
    }
    return self;
}

-(BOOL) open {
    if (self.closedByCommit)
        return NO;
    return [[_dict objectForKey:@"state"] isEqualToString:@"open"];
}

-(NSInteger) number {
    return [[_dict objectForKey:@"number"] intValue];
}

- (BOOL) assignedToCurrentUser {
    return [self.assignee isEqualToString:[UAGithubEngine currentUser]];
}

- (NSString*) assignee {
    NSDictionary* assignee = [_dict objectForKey:@"assignee"];
    if ([assignee isEqual:[NSNull null]])
        return nil;
    else
        return [assignee objectForKey:@"login"];
}

- (NSString*) title {
    return [_dict objectForKey:@"title"];
}

- (NSString*) body {
    return [_dict objectForKey:@"body"];
}

- (void) checkChanges {
    [[UAGithubEngine shared] issue:self.number inRepository:self.repository.name completion:^id(NSArray* result) {
        _dict = [result lastObject];
        [self.delegate issueChanged:self];

        return nil;
    }];
}

- (void) editWithDictionary:(NSDictionary*)editDictionary {
    [[UAGithubEngine shared] editIssue:self.number inRepository:self.repository.name withDictionary:editDictionary completion:^id(id result) {
        [self checkChanges];
        return nil;
    }];
}
- (void) reopen {
    [self editWithDictionary:[NSDictionary dictionaryWithObject:@"open" forKey:@"state"]];

}

- (void) assignToCurrentUser {
    [self editWithDictionary:[NSDictionary dictionaryWithObject:[UAGithubEngine currentUser] forKey:@"assignee"]];

}

- (void) setClosedByCommit:(BOOL)closedByCommit{
    _closedByCommit = closedByCommit;
    [self.delegate issueChanged:self];
}
- (void) close {
    if (self.repository.closeByCommit) {
        [self.repository commitWithIssue:self];
    } else {
        [self editWithDictionary:[NSDictionary dictionaryWithObject:@"closed" forKey:@"state"]];
    }
}


- (NSString*) commitMessage {
    return [NSString stringWithFormat:@"Fixes #%d: \"%@\"",self.number, self.title];
}

@end
