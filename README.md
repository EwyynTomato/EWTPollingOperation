# EWTPollingOperation

Simple polling operation with NSTimer.

# Installation

## Cocoapods

Not available on Cocoapods yet.

```ruby
pod 'EWTPollingOperation', :git => 'https://github.com/EwyynTomato/EWTPollingOperation.git', :tag => '0.1.0'
```
# Usage

- import header

    ```objc
    #import "EWTPollingOperation.h"
    ```

- create and run polling operation

```objc
EWTPollingOperation *operation = [EWTPollingOperation operationWithInterval:1 //call poll handler every 1 second
                                                                withTimeout:5 //timeout in 5 seconds unless poll handler return YES to stop polling
                                                            withPollHandler:^BOOL(id object) {
                                                                //...do something...
                                                                NSLog(@"[%@] called poll handler", object);
                                                                
                                                                //return NO if polling should keep going, YES to stop polling
                                                                return NO;
                                                            }
                                                            withTimeoutHandler:^(id object) {
                                                                //Handle timeout
                                                            }];

[operation setObject:@{@"id":[NSNumber numberWithInt:i]}]; //Optional custom object to be passed on handlers
[operation setStoppedHandler:^(id object) {
    //Optional handler to be called when operation is stopped (either stopped in poll handler or timeout)
}];

[operation start];
```