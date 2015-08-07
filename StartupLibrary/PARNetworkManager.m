//
//  PARNetworkManager.m
//  StartupLibrary
//
//  Created by parejo on 7/8/15.
//  Copyright (c) 2015 PabloParejo. All rights reserved.
//

#import "PARNetworkManager.h"
#import "ParseSettings.h"
@implementation PARNetworkManager

+ (NSData *) listParseClass: (NSString *) parseClass{
    
    NSURL *url = [NSURL URLWithString:[PARSE_URL stringByAppendingPathComponent:parseClass]];
    
    NSURLRequest *request = [self requestForURL: url];
    
    NSError *connectionError = [NSError new];
    NSURLResponse *response = [NSURLResponse new];

    
    NSData *data =  [NSURLConnection sendSynchronousRequest:request
                                          returningResponse:&response
                                                      error:&connectionError];
    

    return data;
}

+ (NSURLRequest *) requestForURL: (NSURL *)url{
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setValue:PARSE_APP_ID forHTTPHeaderField:@"X-Parse-Application-Id"];
    [request setValue:PARSE_API_KEY forHTTPHeaderField:@"X-Parse-REST-API-Key"];
    [request setValue:@"application/json" forHTTPHeaderField:@"application/json"];
    
    
    return [request copy];
}

+ (NSData *) retrieveObjectId:(NSUInteger) objectId forParseClass: (NSString *) parseClass{
    return [NSData new];
}

@end
