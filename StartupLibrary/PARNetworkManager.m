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
    
    NSString *urlString = [PARSE_URL stringByAppendingPathComponent:parseClass];
    NSURLComponents *components = [NSURLComponents componentsWithString:urlString];
    
    NSArray *objectKeys = @[@"title", @"author", @"category", @"tags"];
    NSURLQueryItem *keys = [NSURLQueryItem queryItemWithName:@"keys" value:[objectKeys componentsJoinedByString:@","]];
    components.queryItems = @[keys];
    
    NSURL *url = components.URL;
    
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

+ (NSData *) retrieveObjectId:(NSString*) objectId forParseClass: (NSString *)parseClass{
    NSString *urlString = [[PARSE_URL stringByAppendingPathComponent:parseClass]
                                      stringByAppendingPathComponent:objectId];

    NSURLRequest *request = [self requestForURL:[NSURL URLWithString:urlString]];
    NSError *connectionError = [NSError new];
    NSURLResponse *response = [NSURLResponse new];

    NSData *data =  [NSURLConnection sendSynchronousRequest:request
                                          returningResponse:&response
                                                      error:&connectionError];
    
    return data;
}

@end
