//
//  UAGithubEngine+Shared.h
//  GitHubMenubarIssues
//
//  Created by Sergey Klimov on 2/26/12.
//  Copyright (c) 2012 Self-Employed. All rights reserved.
//

#import "UAGithubEngine.h"

@interface UAGithubEngine (Shared)
+(UAGithubEngine *) shared;
+(NSString*) currentUser;
@end
