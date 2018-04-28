//
//  SyncEngine.m
//  WatsMyGrade
//
//  Created by Manthan Shah on 2018-04-28.
//  Copyright © 2018 Manthan Shah. All rights reserved.
//

#import "SyncEngine.h"

@import CoreData;

@interface SyncEngine ()

@property (nonatomic, strong) NSMutableArray *registeredClassesToSync;

@end

@implementation SyncEngine

@synthesize registeredClassesToSync = _registeredClassesToSync;

+ (SyncEngine *)sharedEngine {
    static SyncEngine *sharedEngine = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedEngine = [[SyncEngine alloc] init];
    });
    
    return sharedEngine;
}

- (void)registerNSManagedObjectClassToSync:(Class)aClass {
    if (!self.registeredClassesToSync) {
        self.registeredClassesToSync = [NSMutableArray array];
    }
    
    if ([aClass isSubclassOfClass:[NSManagedObject class]]) {
        if (![self.registeredClassesToSync containsObject:NSStringFromClass(aClass)]) {
            [self.registeredClassesToSync addObject:NSStringFromClass(aClass)];
        } else {
            NSLog(@"Unable to register %@ as it is already registered", NSStringFromClass(aClass));
        }
    } else {
        NSLog(@"Unable to register %@ as it is not a subclass of NSManagedObject", NSStringFromClass(aClass));
    }
}

@end
