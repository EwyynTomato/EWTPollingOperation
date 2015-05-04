//
//  ViewController.m
//  EWTPollingOperationDemo
//
//  Created by EwyynTomato on 4/30/15.
//  Copyright (c) 2015 ewyyntomato. All rights reserved.
//

#import "ViewController.h"
#import "EWTPollingOperation.h"
#import "EWTPollingManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:@"Demo"];
    
    [self demoManager];
}

- (void)demoOperation {
    EWTPollingOperation *operation = [self createOperation];
    [operation setObject:@{@"A":@"B"}];
    [operation start];
}

- (void)demoManager {
    for (int i=0; i<3; i++) {
        EWTPollingOperation *operation = [self createOperation];
        [operation setObject:@{@"id":[NSNumber numberWithInt:i]}];
        [[EWTPollingManager sharedManager] addOperation:operation];
    }
}

- (EWTPollingOperation *)createOperation {
    EWTPollingOperation *operation = [EWTPollingOperation operationWithInterval:1
                                                                    withTimeout:5
                                                                withPollHandler:^BOOL(id object) {
                                                                    NSLog(@"[%@] called poll handler", object);
                                                                    return NO;
                                                                }
                                                             withTimeoutHandler:^(id object) {
                                                                 NSLog(@"[%@] timeout", object);
                                                             }];
    return operation;
}

@end
