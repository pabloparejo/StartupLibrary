//
//  PARSettings.m
//  StartupLibrary
//
//  Created by Pablo Parejo Camacho on 18/5/15.
//  Copyright (c) 2015 PabloParejo. All rights reserved.
//

#import "PARSettings.h"

@implementation PARSettings

+(void) saveLastBookSelected:(NSString *)objectId{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    [def setObject:objectId forKey:LAST_BOOK_SELECTED_KEY];
    [def synchronize];
}

+(NSString *) objectIdForLastBookSelected{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSString *objectId = [def objectForKey:LAST_BOOK_SELECTED_KEY];
    return objectId;
}

@end
