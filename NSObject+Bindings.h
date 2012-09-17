//
//  NSObject+Bindings.h
//  UIViewExperiments
//
//  Created by Denis Mikhaylov on 15.09.12.
//
//

#import <Foundation/Foundation.h>

typedef id(^ValueTransformerBlock)(id value);

extern const ValueTransformerBlock PassThroughValueTransformer;

@interface NSObject (Bindings)
- (void)bind:(NSString *)key to:(id)object keyPath:(NSString *)keyPath;
- (void)bind:(NSString *)key to:(id)object keyPath:(NSString *)keyPath valueTransformerBlock:(ValueTransformerBlock)valueTransformer;
- (void)unbind:(NSString *)key;
@end