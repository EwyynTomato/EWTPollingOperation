//
//  EWTPollingOperation.m
//
//  Created by EwyynTomato on 4/30/15.
//  Copyright (c) 2015 ewyyntomato. All rights reserved.
//

#import "EWTPollingOperation.h"

@interface EWTPollingOperation ()

/**
 Used for EWTPollingManager, will be called upon stopped, or timeout (which also call stop)
 */
@property (nonatomic, copy) EWTStoppedHandler managerStoppedHandler;

@end

@implementation EWTPollingOperation {
    NSTimer *timeoutTimer;
    NSTimer *pollingTask;
}

- (EWTPollingOperation *)init {
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

#pragma mark -
- (void)commonInit {
    //- Set default values
    [self setTimeout:0];
    [self setInterval:1];
}

#pragma mark - factory
+ (EWTPollingOperation *)operationWithInterval:(long)interval withTimeout:(long)timeout withPollHandler:(BOOL (^)(id object))pollHandler withTimeoutHandler:(void (^)(id object))timeoutHandler {
    EWTPollingOperation *operation = [EWTPollingOperation new];
    [operation setInterval:interval];
    [operation setTimeout:timeout];
    operation.pollHandler    = pollHandler;
    operation.timeoutHandler = timeoutHandler;
    
    return operation;
}

#pragma mark - public functions
- (void)start {
    //: Invalidate previous polling task, if there is any
    [self stop];
    
    [self setIsRunning:YES];
    
    //- Create timeout task to stop polling task
    if (self.timeout > 0) {
        timeoutTimer = [NSTimer scheduledTimerWithTimeInterval:self.timeout
                                                        target:self
                                                      selector:@selector(_timeout)
                                                      userInfo:nil
                                                       repeats:NO];
    }
    
    //- Create a new polling task
    pollingTask = [NSTimer scheduledTimerWithTimeInterval:self.interval
                                                   target:self
                                                 selector:@selector(_poll)
                                                 userInfo:nil
                                                  repeats:YES];
}

- (void)stop {
    if (pollingTask != nil && pollingTask.isValid) {
        [pollingTask invalidate];
        [self setIsRunning:NO];
        
        if (self.stoppedHandler != nil) {
            self.stoppedHandler(self.object);
        }
        
        if (self.managerStoppedHandler != nil) {
            self.managerStoppedHandler(self.object);
        }
    }
}

#pragma mark - private functions
/**
 Called every $(self.interval) seconds until stopped or timeout.
 */
- (void)_poll {
    //- Execute poll handler at time interval
    if (self.pollHandler != nil) {
        BOOL shouldKeepPolling = self.pollHandler(self.object);
        if (shouldKeepPolling) {
            //: Stops polling if poll handler returns NO
            //- Stop timeout timer
            [timeoutTimer invalidate];
            
            //- Stop polling
            [self stop];
        }
    }
}

/**
 Called upon timeout, stop polling task and call timeout handler
 */
- (void)_timeout {
    [self stop];
    if (self.timeoutHandler != nil) {
        self.timeoutHandler(self.object);
    }
}

@end







