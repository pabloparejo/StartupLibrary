//
//  PARBook.h
//  StartupLibrary
//
//  Created by parejo on 1/5/15.
//  Copyright (c) 2015 PabloParejo. All rights reserved.
//

@import Foundation;
@import UIKit;

@interface PARBook : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *author;
@property (strong, nonatomic) NSURL *bookURL;
@property (strong, nonatomic) NSURL *coverURL;
@property (strong, nonatomic) NSString *summary;
@property (strong, nonatomic) NSURL *webURL;
@property (strong, nonatomic) NSString *category;
@property (copy, nonatomic) NSArray *tags;

-(id) initWithTitle:(NSString *)title
             author:(NSString *)author
            bookURL:(NSURL *)bookURL
           coverURL:(NSURL *)coverURL
            summary:(NSString *)summary
             webURL:(NSURL *)webURL
           category:(NSString *)category
               tags:(NSArray *)tags;

+(instancetype) bookWithTitle:(NSString *)title
                       author:(NSString *)author
                      bookURL:(NSURL *)bookURL
                     coverURL:(NSURL *)coverURL
                      summary:(NSString *)summary
                       webURL:(NSURL *)webURL
                     category:(NSString *)category
                         tags:(NSArray *)tags;

-(void) withCoverImage:(void (^)(UIImage *image))completionBlock;

@end
