//
//  NSObject+Bindings.m
//  UIViewExperiments
//
//  Created by Denis Mikhaylov on 15.09.12.
//
//

#import "NSObject+Bindings.h"
#import "BlockBasedObserver.h"
#import "BlockBasedEventHandler.h"
#import <objc/runtime.h>
#import "UIControl+Bindings.h"

static const void *Key = NULL;
const ValueTransformerBlock PassThroughValueTransformer = ^id (id value){return value;};

@implementation NSObject (Bindings)
- (void)bind:(NSString *)key to:(id)object keyPath:(NSString *)keyPath
{
    [self bind:key to:object keyPath:keyPath valueTransformerBlock:nil];
}

- (void)bind:(NSString *)key to:(id)object keyPath:(NSString *)keyPath valueTransformerBlock:(ValueTransformerBlock)valueTransformer
{
    __block id blockObject = object;
    __block NSObject *blockSelf = self;
    BlockBasedObserver *observer = [object observerForKeyPath:keyPath block:^
    {
        id value = [blockObject valueForKeyPath:keyPath];
        id transformedValue = valueTransformer ? valueTransformer(value) : value;
        if (![transformedValue isEqual:[self valueForKey:key]])
        {
            [blockSelf setValue:transformedValue forKey:key];
        }
    }];
    [[self bindings] setObject:observer forKey:key];
    [observer start];
}

- (void)unbind:(NSString *)key
{
    [[self bindings] removeObjectForKey:key];
}

- (NSMutableDictionary *)bindings
{
    NSMutableDictionary *dictionary = objc_getAssociatedObject(self, Key);
    if (!dictionary)
    {
        dictionary = [NSMutableDictionary dictionary];
        objc_setAssociatedObject(self, Key, dictionary, OBJC_ASSOCIATION_RETAIN);
    }
    return dictionary;
}

- (id)observerForKeyPath:(NSString *)keyPath block:(ObservationBlock)block
{
    return [[[BlockBasedObserver alloc] initWithTarget:self keyPath:keyPath block:block] autorelease];
}
@end

@implementation UIControl (Observer)
- (id)observerForKeyPath:(NSString *)keyPath block:(ObservationBlock)block
{
    UIControlEvents events = [self eventsForKeyPath:keyPath];
    
    if (events == 0) return [super observerForKeyPath:keyPath block:block];
    
    return [[[BlockBasedEventHandler alloc] initWithControl:self keyPath:keyPath events:events block:block] autorelease];
}
@end



