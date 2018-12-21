//
//  ReduxySimplePlayer.h
//  Reduxy_Example
//
//  Created by yjkim on 27/04/2018.
//  Copyright © 2018 skyofdwarf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReduxyRecorder.h"

FOUNDATION_EXTERN ReduxyActionType ReduxyPlayerActionJump;


@interface ReduxySimplePlayer : NSObject <ReduxyPlayer>
@property (assign, nonatomic, readonly) NSInteger position;

+ (ReduxyMiddleware)middleware;
+ (ReduxyReducerTransducer)reducer;
    
- (void)load:(NSArray<id<ReduxyRecorderItem>> *)items dispatch:(ReduxyDispatch)dispatch;

- (NSInteger)length;

- (ReduxyAction)jump:(NSInteger)index;

- (ReduxyAction)prev;
- (ReduxyAction)next;

- (void)reset;
- (void)clear;

@end
