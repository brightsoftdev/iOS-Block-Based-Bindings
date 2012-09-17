//
//  UITextField+Bindings.m
//  UIViewExperiments
//
//  Created by Denis Mikhaylov on 16.09.12.
//
//

#import "UITextField+Bindings.h"
#import "UIControl+Bindings.h"

@implementation UITextField (Bindings)
- (UIControlEvents)eventsForKeyPath:(NSString *)keyPath
{
    if ([keyPath isEqualToString:@"text"])
    {
        return UIControlEventEditingChanged;
    }
    return [super eventsForKeyPath:keyPath];
}
@end
