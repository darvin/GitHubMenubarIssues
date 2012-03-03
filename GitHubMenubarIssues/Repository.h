//
//  Repository.h
//  GitHubMenubarIssues
//
//  Created by Sergey Klimov on 3/3/12.
//  Copyright (c) 2012 Self-Employed. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Issue;
@interface Repository : NSObject <NSCoding>
@property (copy) NSString* name;
@property (copy) NSURL * path;
@property (strong) NSMutableArray *issues;
@property BOOL closeByCommit;
@property BOOL showInMenu;

+(void) fetchReposForCurrentUserCompletion:(id(^)(NSArray * repos))successBlock_;

-(id) initWithName:(NSString*)name;
-(void) fetchIssues;
-(void) commitWithIssue:(Issue*)issue;
@end
