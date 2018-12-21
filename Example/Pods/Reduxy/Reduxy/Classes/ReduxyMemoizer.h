//
//  ReduxyMemoizer.h
//  Reduxy_Example
//
//  Created by yjkim on 02/05/2018.
//  Copyright © 2018 skyofdwarf. All rights reserved.
//

#ifndef ReduxyMomoizer_h
#define ReduxyMomoizer_h



#import <Foundation/Foundation.h>
#import "ReduxyTypes.h"


typedef id (^unary_argumented_block)(NSArray *args);

typedef unary_argumented_block memoizable_block;
typedef unary_argumented_block memoized_block;

FOUNDATION_EXTERN memoized_block (^memoize)(memoizable_block);

/**
 memoized result selector, do some computations with argsuments
 */
typedef unary_argumented_block memoized_selector_block;

/**
 type of `memoizeSelector` function
 */
typedef selector_block (^memoized_selector_generator)(NSArray<selector_block> *, memoized_selector_block);


/**
 create memoized selector of `resultSelector` 
 */
FOUNDATION_EXTERN memoized_selector_generator memoizeSelector;


#endif /* ReduxyMomoizer_h */
