//
//  WebAPIClient.h
//  WatsMyGrade
//
//  Created by Manthan Shah on 2018-04-27.
//  Copyright © 2018 Manthan Shah. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface WebAPIClient : AFHTTPClient

+ (WebAPIClient*)sharedClient;

- (NSMutableURLRequest*)getRequestForClass:(NSString*)className parameters:(NSDictionary*)parameters;
- (NSMutableURLRequest*)getRequestForAllRecordsOfClass:(NSString*)className updateAfterDate:(NSDate*)updatedDate;

@end
