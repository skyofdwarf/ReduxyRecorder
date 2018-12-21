//
//  ReduxySimpleRecorder.h
//  Reduxy_Example
//
//  Created by yjkim on 27/04/2018.
//  Copyright © 2018 skyofdwarf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReduxyRecorder.h"

/**
 ReduxySimpleRecorder
 */
@interface ReduxySimpleRecorder : NSObject
<
ReduxyRecorder,
ReduxyStoreSubscriber
>
@property (assign, nonatomic, readonly) BOOL recording;

/**
 create a instance of ReduxySimpleRecorder

 @param store instance of ReduxyStore
 @param typesToIgnore list of action type to ignore
 @return recorder instance
 */
- (instancetype)initWithStore:(id<ReduxyStore>)store actionTypesToIgnore:(NSArray<ReduxyActionType> *)typesToIgnore;
- (instancetype)initWithStore:(id<ReduxyStore>)store;

#pragma mark - ReduxyRecorder protocol

- (BOOL)record:(ReduxyAction)action state:(ReduxyState)state;

- (NSArray<ReduxyRecorderItem> *)items;

- (void)start;
- (void)stop;

- (void)clear;

- (void)save;
- (void)load;

@end
