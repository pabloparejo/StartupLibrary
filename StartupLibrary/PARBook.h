//
//  PARBook.h
//  StartupLibrary
//
//  Created by parejo on 1/5/15.
//  Copyright (c) 2015 PabloParejo. All rights reserved.
//

@import Foundation;
@import UIKit;
@import CoreData;

#import "ReaderDocument.h"
#import "_PARBook.h"

@interface PARBook : _PARBook

@property (strong, nonatomic, readonly) UIImage *image;
@property (strong, nonatomic, readonly) ReaderDocument *document;

+ (instancetype) bookWithContext:(NSManagedObjectContext *)context
                        objectId:(NSString *) objectId
                           title:(NSString *)title
                          author:(NSString *)author
                         bookURL:(NSURL *)bookURL
                        coverURL:(NSURL *)coverURL
                         summary:(NSString *)summary
                          webURL:(NSURL *)webURL
                        category:(NSString *)category
                            tags:(NSArray *)tags;

+ (instancetype) bookWithContext:(NSManagedObjectContext *)context
                      dictionary:(NSDictionary *) dictionary;

-(void) retrieveDetail;


-(void) freeUpMemory;
-(void) downloadCoverImage:(void (^)())completionBlock;
-(void) downloadBookPDF:(void (^)())completionBlock;

@end
