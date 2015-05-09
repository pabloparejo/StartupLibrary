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


-(NSUInteger)countForKey:(NSString *)key;
-(NSString *)keyForSection:(NSUInteger)section;
-(NSArray *) booksForKey:(NSString *)key;
-(PARBook *) bookAtIndexPath:(NSIndexPath *)indexPath;

@end
