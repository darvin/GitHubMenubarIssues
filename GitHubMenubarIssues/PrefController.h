//
//  PrefController.h
//  GitHubMenubarIssues
//
//  Created by Sergey Klimov on 3/3/12.
//  Copyright (c) 2012 Self-Employed. All rights reserved.
//

#import <Foundation/Foundation.h>


@class PrefController;

@protocol PrefControllerDelegate <NSObject>
@optional
-(void) prefControllerClosed:(PrefController*)prefController;

@end

@interface PrefController : NSWindowController <NSWindowDelegate> {
}

@property (assign, nonatomic) NSArray *repos;
@property (copy) NSString* username;
@property (copy) NSString* password;
@property (assign) IBOutlet NSArrayController *repoArrayController;

@property (assign) IBOutlet NSTextField *createRepoName;

+(PrefController*) sharedPrefController;
@property (weak) id<PrefControllerDelegate> delegate;

@end
