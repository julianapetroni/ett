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

#import "AnalogClockPlugin.h"

FOUNDATION_EXPORT double analog_clockVersionNumber;
FOUNDATION_EXPORT const unsigned char analog_clockVersionString[];

