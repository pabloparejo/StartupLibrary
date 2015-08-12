//
//  PARNetworkManager.m
//  StartupLibrary
//
//  Created by parejo on 7/8/15.
//  Copyright (c) 2015 PabloParejo. All rights reserved.
//

#import "PARNetworkManager.h"
#import "ParseSettings.h"
#import "NSDate+Formatters.h"

@implementation PARNetworkManager



+ (NSURLQueryItem *) listBookObjectKeys{
    NSArray *objectKeys = @[@"title", @"author", @"category", @"tags", @"createdAt", @"updatedAt"];
    NSURLQueryItem *keys = [NSURLQueryItem queryItemWithName:@"keys" value:[objectKeys componentsJoinedByString:@","]];
    return keys;
}


+ (NSData *) listParseClass:(NSString *) parseClass fromDate:(NSDate *) date{
    NSURLQueryItem *listObjectKeys;
    NSDictionary *dateFilter = @{@"updatedAt": @{@"$gt": [NSDate stringWithISO8601Date:date]}};
    NSError *jsonError;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dateFilter options:NSJSONWritingPrettyPrinted error:&jsonError];
    NSLog(@"%@", jsonError);
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSURLQueryItem *dateQuery = [NSURLQueryItem queryItemWithName:@"where" value:jsonString];

    if ([parseClass isEqualToString:PARSE_CLASS_BOOK]) {
        listObjectKeys = [self listBookObjectKeys];
    }
    
    NSURLRequest *request = [self listRequestForClass:parseClass
                                       withQueryItems:@[listObjectKeys, dateQuery]];
    
    NSError *connectionError = [NSError new];
    NSURLResponse *response = [NSURLResponse new];
    
    
    NSData *data =  [NSURLConnection sendSynchronousRequest:request
                                          returningResponse:&response
                                                      error:&connectionError];
    
    
    return data;
}

+ (NSURLRequest *) listRequestForClass:(NSString *)parseClass withQueryItems:(NSArray *)queryItems{
    NSString *urlString = [PARSE_URL stringByAppendingPathComponent:parseClass];
    NSURLComponents *components = [NSURLComponents componentsWithString:urlString];
    components.queryItems = queryItems;
    NSURL *url = components.URL;
    return [self requestForURL:url];
}


+ (NSData *) listParseClass: (NSString *) parseClass{
    
    NSURLQueryItem *listObjectKeys;
    if ([parseClass isEqualToString:PARSE_CLASS_BOOK]) {
        listObjectKeys = [self listBookObjectKeys];
    }
    
    NSURLRequest *request = [self listRequestForClass:parseClass
                                       withQueryItems:@[listObjectKeys]];
    
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
