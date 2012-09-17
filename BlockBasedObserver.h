//
//  BlockBasedObserver.h
//  UIViewExperiments
//
//  Created by Denis Mikhaylov on 16.09.12.
//
//

#import <Foundation/Foundation.h>

#import "ObservationBlock.h"

@interface BlockBasedObserver : NSObject
- (id)initWithTarget:(id)target keyPath:(NSString *)keyPath block:(ObservationBlock)block;
- (void)start;
- (void)stop;
@end