//
//  NSDate+Formatters.m
//  StartupLibrary
//
//  Created by parejo on 12/8/15.
//  Copyright (c) 2015 PabloParejo. All rights reserved.
//

#import "NSDate+Formatters.h"

@implementation NSDate (Formatters)

+ (NSDate *) dateWithISO8601String:(NSString *) string{
    NSString *dateString = string;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
    // Always use this locale when parsing fixed format date strings
    NSLocale *posix = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    [formatter setLocale:posix];
    return [formatter dateFromString:dateString];
}

@end
