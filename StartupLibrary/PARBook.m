//
//  PARBook.m
//  StartupLibrary
//
//  Created by parejo on 1/5/15.
//  Copyright (c) 2015 PabloParejo. All rights reserved.
//

#import "PARBook.h"

@interface PARBook()
@property (strong, nonatomic, readwrite) UIImage *image;
@end

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
                       summary:[dictionary objectForKey:@"description"]
                        webURL:[NSURL URLWithString:[dictionary objectForKey:@"web_url"]]
                      category:[dictionary objectForKey:@"category"]
                          tags:[dictionary objectForKey:@"tags"]];
}

-(void) freeUpMemory{
    // Just in case..
    [self cacheImage];
    self.image = nil;
}

-(NSString *) pathForChachedImage{
    NSString *cacheDir = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSString *fileName = [NSString stringWithFormat:@"%@", self.title];
    return [cacheDir stringByAppendingString:fileName];
}

-(void) cacheImage{
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0), ^{
        [UIImagePNGRepresentation(self.image) writeToFile:[self pathForChachedImage] atomically:YES];
    });
}

-(void) downloadCoverImage:(void (^)())completionBlock{
    if (self.image != nil) {
        completionBlock();
    }else{
        // Trying to get the image from cacheDir
        self.image = [UIImage imageWithContentsOfFile:[self pathForChachedImage]];
        if (self.image == nil) {
            __weak typeof(self) weakSelf = self;
            dispatch_async(dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0), ^{
                // QOS_CLASS_DEFAULT is the 3rd priority queue
                UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:self.coverURL]];
                // image loading error
                if (image == nil){
                    image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"oops" ofType:@".png"]];
                }
                weakSelf.image = image;
                // Returning to main queue
                dispatch_async(dispatch_get_main_queue(), ^{
                    completionBlock(image);
                });
            });
        }else{
            completionBlock();
        }
    }
}

@end
