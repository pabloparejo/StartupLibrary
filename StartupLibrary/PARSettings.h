//
//  PARSettings.h
//  StartupLibrary
//
//  Created by Pablo Parejo Camacho on 18/5/15.
//  Copyright (c) 2015 PabloParejo. All rights reserved.
//

@import UIKit;

#define LAST_BOOK_SELECTED_KEY @"LASTBOOKSELECTED"
#define SAVE_RATE 5

@interface PARSettings : NSObject

+(void) saveLastBookSelected:(NSString *)objectId;
+(NSString *) objectIdForLastBookSelected;
@end
