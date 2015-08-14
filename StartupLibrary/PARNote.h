//
//  PARNote.h
//  StartupLibrary
//
//  Created by parejo on 11/8/15.
//  Copyright (c) 2015 PabloParejo. All rights reserved.
//

@import Foundation;
@import CoreData;

#import "_PARNote.h"

@interface PARNote : _PARNote

+ (instancetype) noteWithContext:(NSManagedObjectContext *)context
                            text:(NSString *)text;

@end
