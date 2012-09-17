//
//  BlockBasedEventHandler.m
//  UIViewExperiments
//
//  Created by Denis Mikhaylov on 16.09.12.
//
//

#import "BlockBasedEventHandler.h"
#import "BlockBasedObserver.h"
@interface BlockBasedEventHandler ()
@property (nonatomic, retain) UIControl *control;
@property (nonatomic, assign) UIControlEvents events;
@property (nonatomic, copy) ObservationBlock block;
@property (nonatomic, retain) BlockBasedObserver *observer;
@end

@implementation BlockBasedEventHandler
- (id)initWithControl:(UIControl *)control keyPath:(NSString *)keyPath events:(UIControlEvents)events block:(ObservationBlock)block
{
    self = [super init];
    if (self)
    {
        _control = [control retain];
        _observer = [[BlockBasedObserver alloc] initWithTarget:control keyPath:keyPath block:block];
        _events = events;
        _block = [block copy];
    }
    return self;
}

- (void)dealloc
{
    [self stop];
    [_control release];
    [_observer release];
    [_block release];
    [super dealloc];
}

- (void)start
{
    [self.control addTarget:self action:@selector(handleEvent) forControlEvents:self.events];
    [self.observer start];
}

- (void)stop
{
    [self.control removeTarget:self action:@selector(handleEvent) forControlEvents:self.events];
    [self.observer stop];
}

- (void)handleEvent
{
    [self invokeBlock];
}

- (void)invokeBlock
{
    self.block();
}
@end
