//
//  PARLibrary.h
//  StartupLibrary
//
//  Created by parejo on 2/5/15.
//  Copyright (c) 2015 PabloParejo. All rights reserved.
//


@import Foundation;
#import "PARBook.h"
@interface PARLibrary : NSObject

@property (nonatomic, readonly) NSUInteger numberOfSections;

-(void) freeUpMemory;

-(id) initWithContext:(NSManagedObjectContext *)context;

-(NSUInteger)countForSection:(NSUInteger)section;
-(NSString *)titleForSection:(NSUInteger)section;
-(NSArray *) booksForSection:(NSUInteger)section;
-(PARBook *) bookAtIndexPath:(NSIndexPath *)indexPath;

@end
