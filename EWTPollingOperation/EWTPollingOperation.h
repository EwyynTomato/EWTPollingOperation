//
//  EWTPollingOperation.h
//
//  Created by EwyynTomato on 4/30/15.
//  Copyright (c) 2015 ewyyntomato. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EWTPollingOperation;
typedef BOOL (^EWTPollingHandler)(id object);
typedef void (^EWTTimeoutHandler)(id object);
typedef void (^EWTStoppedHandler)(id object);

@interface EWTPollingOperation : NSObject

/**
 Default customization factory
 */
+ (EWTPollingOperation *)operationWithInterval:(long)interval withTimeout:(long)timeout withPollHandler:(BOOL (^)(id object))pollHandler withTimeoutHandler:(void (^)(id object))timeoutHandler;

/**
 Polling interval, pollHandler will be called every interval
 
    - default is 1 (second)
 */
@property (nonatomic, assign) long interval;

/**
 Timeout in seconds
 
    - default is 0 (ZERO)
    - if == 0, polling will NEVER timeout
 */
@property (nonatomic, assign) long timeout;

/**
 Holder for custom object that can be passed in pollHandler/timeoutHandler block.
 */
@property (nonatomic, strong) id object;

/**
 Will be called every poll interval until it reached timeout, or until it return YES.
 
    - return NO  to KEEP polling operation
    - return YES to STOP polling operation
 */
@property (nonatomic, copy) EWTPollingHandler pollHandler;

/**
 Will be called when polling operation has timeout
 */
@property (nonatomic, copy) EWTTimeoutHandler timeoutHandler;

/**
 Will be called upon stopped, or timeout (which also call stop)
 */
@property (nonatomic, copy) EWTStoppedHandler stoppedHandler;

/**
 If there's any operation running
 
    - return YES when polling is running (start called, but haven't timeout or called stop)
    - return NO whenpolling is not running (either timeout or stop called)
 */
@property (nonatomic, assign) BOOL isRunning;

/**
 Start polling operation
 */
- (void)start;

/**
 Stop polling operation
 */
- (void)stop;

@end
