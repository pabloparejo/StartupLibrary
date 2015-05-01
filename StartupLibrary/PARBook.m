//
//  PARBook.m
//  StartupLibrary
//
//  Created by parejo on 1/5/15.
//  Copyright (c) 2015 PabloParejo. All rights reserved.
//

#import "PARBook.h"

@implementation PARBook

-(id) initWithTitle:(NSString *)title
             author:(NSString *)author
            bookURL:(NSURL *)bookURL
           coverURL:(NSURL *)coverURL
            summary:(NSString *)summary
             webURL:(NSURL *)webURL
           category:(NSString *)category
               tags:(NSArray *)tags{
    if (self = [super init]){
		_title = title;
		_author = author;
		_bookURL = bookURL;
		_coverURL = coverURL;
		_summary = summary;
		_webURL = webURL;
		_category = category;
		_tags = tags;	
	}
    return self;
}

+(instancetype) bookWithTitle:(NSString *)title
                       author:(NSString *)author
                      bookURL:(NSURL *)bookURL
                     coverURL:(NSURL *)coverURL
                      summary:(NSString *)summary
                       webURL:(NSURL *)webURL
                     category:(NSString *)category 
                         tags:(NSArray *)tags{

    return [[self alloc] initWithTitle:title
                                author:author
                               bookURL:bookURL
                              coverURL:coverURL
                               summary:summary
                                webURL:webURL
                              category:category
                                  tags:tags];
}

@end
