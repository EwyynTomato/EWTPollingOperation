//
//  EWTPollingManager.m
//
//  Created by EwyynTomato on 4/30/15.
//  Copyright (c) 2015 ewyyntomato. All rights reserved.
//

#import "EWTPollingManager.h"

@interface EWTPollingOperation ()
@property (nonatomic, copy) EWTStoppedHandler managerStoppedHandler;
@end

@implementation EWTPollingManager

- (id)init {
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    self.operations = [NSMutableArray new];
}

#pragma mark - Singleton
+ (EWTPollingManager *)sharedManager {
    static EWTPollingManager *sharedManager = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedManager = [EWTPollingManager new];
    });
    return sharedManager;
}

#pragma mark -
- (void)addOperation:(EWTPollingOperation *)operation {
    [self.operations addObject:operation];
    
    __weak typeof(self)      weakself      = self;
    __weak typeof(operation) weakOperation = operation;
    operation.managerStoppedHandler = ^(id object) {
        //- Remove operation from list of operations upon stopped
        [weakself.operations removeObject:weakOperation];
    };
    [operation start];
}


@end
