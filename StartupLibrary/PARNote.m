//
//  PARNote.m
//  StartupLibrary
//
//  Created by parejo on 11/8/15.
//  Copyright (c) 2015 PabloParejo. All rights reserved.
//

#import "PARNote.h"

@implementation PARNote

+ (instancetype) noteWithContext:(NSManagedObjectContext *)context
                            book:(PARBook *)book
                            text:(NSString *)text{
    PARNote *note = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass(self.class)
                                                  inManagedObjectContext:context];

    note.book = book;
    note.text = text;
    return note;
}

@end
