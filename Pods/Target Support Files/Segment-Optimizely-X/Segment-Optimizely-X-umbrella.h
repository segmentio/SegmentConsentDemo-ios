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

#import "SEGOptimizelyXIntegration.h"
#import "SEGOptimizelyXIntegrationFactory.h"

FOUNDATION_EXPORT double Segment_Optimizely_XVersionNumber;
FOUNDATION_EXPORT const unsigned char Segment_Optimizely_XVersionString[];

