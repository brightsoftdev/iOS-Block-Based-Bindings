//
//  BlockBasedEventHandler.h
//  UIViewExperiments
//
//  Created by Denis Mikhaylov on 16.09.12.
//
//

#import <Foundation/Foundation.h>
#import "ObservationBlock.h"

@interface BlockBasedEventHandler : NSObject
- (id)initWithControl:(UIControl *)control keyPath:(NSString *)keyPath events:(UIControlEvents)events block:(ObservationBlock)block;
- (void)start;
- (void)stop;
@end

