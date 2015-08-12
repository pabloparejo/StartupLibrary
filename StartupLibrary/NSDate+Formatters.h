//
//  NSDate+Formatters.h
//  StartupLibrary
//
//  Created by parejo on 12/8/15.
//  Copyright (c) 2015 PabloParejo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Formatters)

+ (NSDate *) dateWithISO8601String:(NSString *) string;

@end
