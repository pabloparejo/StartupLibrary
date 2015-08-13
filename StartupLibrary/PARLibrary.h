//
//  PARLibrary.h
//  StartupLibrary
//
//  Created by parejo on 2/5/15.
//  Copyright (c) 2015 PabloParejo. All rights reserved.
//


@import Foundation;
@import CoreData;
@interface PARLibrary : NSObject

+ (void) fetchBooksWithContext:(NSManagedObjectContext *)context;

@end
