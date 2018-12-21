#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "ReduxyRecorder.h"
#import "ReduxySimplePlayer.h"
#import "ReduxySimpleRecorder.h"

FOUNDATION_EXPORT double ReduxyRecorderVersionNumber;
FOUNDATION_EXPORT const unsigned char ReduxyRecorderVersionString[];

