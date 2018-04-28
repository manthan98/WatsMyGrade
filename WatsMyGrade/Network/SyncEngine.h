//
//  SyncEngine.h
//  WatsMyGrade
//
//  Created by Manthan Shah on 2018-04-28.
//  Copyright © 2018 Manthan Shah. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SyncEngine : NSObject

+ (SyncEngine*)sharedEngine;

- (void)registerNSManagedObjectClassToSync:(Class)aClass;

@end
