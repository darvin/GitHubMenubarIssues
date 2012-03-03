//
//  Issue.h
//  GitHubMenubarIssues
//
//  Created by Sergey Klimov on 3/3/12.
//  Copyright (c) 2012 Self-Employed. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Repository.h"


@class Issue;
@protocol IssueDelegate <NSObject>
- (void) issueChanged:(Issue*)issue;
@end

@interface Issue : NSObject {
    NSDictionary* _dict;
}
@property (readonly) NSString* title;
@property (readonly) NSString* assignee;
@property (readonly) NSString* body;
@property (readonly) NSArray* tags;
@property (readonly) NSInteger number;

@property (readonly) BOOL open;
@property (nonatomic) BOOL closedByCommit;
@property (readonly) BOOL assignedToCurrentUser;
@property (assign) id<IssueDelegate> delegate;
@property (assign) Repository* repository;

-(id) initWithDictionary:(NSDictionary*)issueDictionary andRepository:(Repository*)repository;
- (void) assignToCurrentUser;
- (void) close;
- (void) reopen;
- (NSString*) commitMessage;
@end
