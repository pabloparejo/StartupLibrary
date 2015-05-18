//
//  PARSettings.m
//  StartupLibrary
//
//  Created by Pablo Parejo Camacho on 18/5/15.
//  Copyright (c) 2015 PabloParejo. All rights reserved.
//

#import "PARSettings.h"

@implementation PARSettings

+(void)saveLastBookSelected:(NSIndexPath *)indexPath{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    [def setObject:@[@(indexPath.section), @(indexPath.row)] forKey:LAST_BOOK_SELECTED_KEY];
    [def synchronize];
}

+(NSIndexPath *) indexPathForLastBookSelected{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSArray *coords;
    if ((coords = [def objectForKey:LAST_BOOK_SELECTED_KEY])) {
        long row = [[coords objectAtIndex:0] integerValue];
        long section = [[coords objectAtIndex:1] integerValue];
        return [NSIndexPath indexPathForRow:row inSection:section];
    }
    return nil;
}

@end
