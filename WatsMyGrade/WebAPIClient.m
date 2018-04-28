//
//  WebAPIClient.m
//  WatsMyGrade
//
//  Created by Manthan Shah on 2018-04-27.
//  Copyright © 2018 Manthan Shah. All rights reserved.
//

#import "WebAPIClient.h"
#import "AFJSONRequestOperation.h"

static NSString* const kWebAPIBaseURL = @"http://localhost:3005/v1/";

@implementation WebAPIClient

+ (WebAPIClient*)sharedClient {
    static WebAPIClient *sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedClient = [[WebAPIClient alloc] initWithBaseURL:[NSURL URLWithString:kWebAPIBaseURL]];
    });
    
    return sharedClient;
}

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    
    if (self) {
        [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
        [self setParameterEncoding:AFJSONParameterEncoding];
    }
    
    return self;
}

/**
 * Will return an NSMutableURLRequest used to GET from the API for an
 * object with class name 'className' and submit an NSDictionary of parameters.
 */
- (NSMutableURLRequest *)getRequestForClass:(NSString *)className parameters:(NSDictionary *)parameters {
    NSMutableURLRequest *request = nil;
    request = [self requestWithMethod:@"GET" path:[NSString stringWithFormat:@"classes/%@", className] parameters:parameters];
    return request;
}

/**
 * Will return an NSMutableURLRequest to GET data from the API after
 * that were updated after a specified NSDate.
 */
- (NSMutableURLRequest *)getRequestForAllRecordsOfClass:(NSString *)className updateAfterDate:(NSDate *)updatedDate {
    NSMutableURLRequest *request = nil;
    NSDictionary *parameters = nil;
    
    if (updatedDate) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.'999Z'"];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
        
        NSString *jsonString = [NSString
                                stringWithFormat:@"{\"updatedAt\":{\"$gte\":{\"__type\":\"Date\",\"iso\":\"%@\"}}}",
                                [dateFormatter stringFromDate:updatedDate]];
        
        parameters = [NSDictionary dictionaryWithObject:jsonString forKey:@"where"];
    }
    
    request = [self getRequestForClass:className parameters:parameters];
    return request;
}

@end
