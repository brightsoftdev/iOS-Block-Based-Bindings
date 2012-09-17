//
//  UISwitch+Bindings.m
//  UIViewExperiments
//
//  Created by Denis Mikhaylov on 16.09.12.
//
//

#import "UISwitch+Bindings.h"
#import "UIControl+Bindings.h"
@implementation UISwitch (Bindings)
- (UIControlEvents)eventsForKeyPath:(NSString *)keyPath
{
    if ([keyPath isEqualToString:@"on"])
    {
        return UIControlEventValueChanged;
    }
    return [super eventsForKeyPath:keyPath];
}
@end
