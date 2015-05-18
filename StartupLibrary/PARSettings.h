//
//  PARSettings.h
//  StartupLibrary
//
//  Created by Pablo Parejo Camacho on 18/5/15.
//  Copyright (c) 2015 PabloParejo. All rights reserved.
//

@import UIKit;

#define LAST_BOOK_SELECTED_KEY @"LASTBOOKSELECTED"

@interface PARSettings : NSObject

+(void) saveLastBookSelected:(NSIndexPath *)indexPath;
+(NSIndexPath *) indexPathForLastBookSelected;
@end
