//
//  EWTPollingManager.h
//
//  Created by EwyynTomato on 4/30/15.
//  Copyright (c) 2015 ewyyntomato. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EWTPollingOperation.h"

@interface EWTPollingManager : NSObject

/**
 List of operations running
 */
@property (nonatomic, strong) NSMutableArray *operations;

/**
 Our evil, beloved singleton manager
 */
+ (EWTPollingManager *)sharedManager;

/**
 Add an operation and run it
 */
- (void)addOperation:(EWTPollingOperation *)operation;

@end
