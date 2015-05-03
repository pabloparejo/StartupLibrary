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

-(id) initWithJSONDictionary:(NSDictionary *) dictionary{
    return [self initWithTitle:[dictionary objectForKey:@"title"]
                        author:[dictionary objectForKey:@"author"]
                       bookURL:[NSURL URLWithString:[dictionary objectForKey:@"book_url"]]
                      coverURL:[NSURL URLWithString:[dictionary objectForKey:@"cover_url"]]
                       summary:[dictionary objectForKey:@"summary"]
                        webURL:[NSURL URLWithString:[dictionary objectForKey:@"web_url"]]
                      category:[dictionary objectForKey:@"category"]
                          tags:[dictionary objectForKey:@"tags"]];
}

-(void) withCoverImage:(void (^)(UIImage *image))completionBlock{
    
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0), ^{
        // QOS_CLASS_DEFAULT is the 3rd priority queue
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:self.coverURL]];
        
        // Returning to main queue
        dispatch_async(dispatch_get_main_queue(), ^{
            completionBlock(image);
        });
    });
    
}

@end
