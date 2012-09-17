//
//  BlockBasedObserver.m
//  UIViewExperiments
//
//  Created by Denis Mikhaylov on 16.09.12.
//
//

#import "BlockBasedObserver.h"


@interface BlockBasedObserver ()
@property (nonatomic, retain) id target;
@property (nonatomic, copy) NSString *keyPath;
@property (nonatomic, copy) ObservationBlock block;
@end

@implementation BlockBasedObserver
- (id)initWithTarget:(id)target keyPath:(NSString *)keyPath block:(ObservationBlock)block
{
    self = [super init];
    if (self)
    {
        _target = [target retain];
        _keyPath = [keyPath copy];
        _block = [block copy];
    }
    return self;
}

- (void)start
{
    [self.target addObserver:self forKeyPath:self.keyPath options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew context:NULL];
}

- (void)stop
{
    [self.target removeObserver:self forKeyPath:self.keyPath];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    self.block();
}

- (void)dealloc
{
    [self stop];
    [_target release];
    [_keyPath release];
    [_block release];
    [super dealloc];
}
@end