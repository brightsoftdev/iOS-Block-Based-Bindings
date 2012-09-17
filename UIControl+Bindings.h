//
//  UIControl+Bindings.h
//  UIViewExperiments
//
//  Created by Denis Mikhaylov on 16.09.12.
//
//

#import <UIKit/UIKit.h>

@interface UIControl (Bindings)
- (UIControlEvents)eventsForKeyPath:(NSString *)keyPath;
@end
