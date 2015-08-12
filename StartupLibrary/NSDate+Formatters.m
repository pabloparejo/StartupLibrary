//
//  NSDate+Formatters.m
//  StartupLibrary
//
//  Created by parejo on 12/8/15.
//  Copyright (c) 2015 PabloParejo. All rights reserved.
//

#import "NSDate+Formatters.h"

@implementation NSDate (Formatters)

+ (NSDateFormatter *) formaterForISO8601{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
    return formatter;
}

+ (NSDate *) dateWithISO8601String:(NSString *) string{
    NSString *dateString = string;
    // Always use this locale when parsing fixed format date strings
    //NSLocale *posix = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    NSDateFormatter *formatter = [self formaterForISO8601];
    //[formatter setLocale:posix];
    return [formatter dateFromString:dateString];
}

+(NSString *) stringWithISO8601Date:(NSDate *) date{
    NSDateFormatter *formatter = [self formaterForISO8601];
    return [formatter stringFromDate:date];
}

@end
