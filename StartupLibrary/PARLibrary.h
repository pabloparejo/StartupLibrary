//
//  PARLibrary.h
//  StartupLibrary
//
//  Created by parejo on 2/5/15.
//  Copyright (c) 2015 PabloParejo. All rights reserved.
//


@import Foundation;
@import CoreData;
@class PARBook;
@interface PARLibrary : NSObject

+ (void) fetchBooksWithContext:(NSManagedObjectContext *)context;
+ (PARBook *) lastBookUpdatedWithContext:(NSManagedObjectContext *)context;
@end
