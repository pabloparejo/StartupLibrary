//
//  PARBook.m
//  StartupLibrary
//
//  Created by parejo on 1/5/15.
//  Copyright (c) 2015 PabloParejo. All rights reserved.
//

#import "PARBook.h"
#import "PARNetworkManager.h"
#import "NSDate+Formatters.h"

@interface PARBook()
@property (strong, nonatomic, readwrite) UIImage *image;
@property (strong, nonatomic, readwrite) ReaderDocument *document;
@end

@implementation PARBook

@synthesize image;
@synthesize document;

+(instancetype) bookWithContext:(NSManagedObjectContext *)context
                       objectId:(NSString *)objectId
                          title:(NSString *)title
                         author:(NSString *)author
                        bookURL:(NSString *)bookURL
                       coverURL:(NSString *)coverURL
                        summary:(NSString *)summary
                         webURL:(NSString *)webURL
                       category:(NSString *)category
                           tags:(NSArray *)tags
                       createdAt:(NSDate *)createdAt
                       updatedAt:(NSDate *)updatedAt{
    
    PARBook *book = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass(self.class)
                                                  inManagedObjectContext:context];
    book.objectId = objectId;
    book.title = title;
    book.author = author;
    book.bookURL = bookURL;
    book.coverURL = coverURL;
    book.summary = summary;
    book.webURL = webURL;
    book.category = category;
    book.tags = tags;
    book.createdAt = createdAt;
    book.updatedAt = updatedAt;
    return book;
}

+ (instancetype) bookWithContext:(NSManagedObjectContext *)context
                      dictionary:(NSDictionary *)dictionary{

    PARBook *book = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass(self.class)
                                                  inManagedObjectContext:context];
    [book updateModelWithJSONDictionary:dictionary];
    return book;
}

- (BOOL) isDetailDataLoaded{
    // Summary is loaded on retrieveDetailOnly
    return self.summary != nil;
}

-(void) updateModelWithJSONDictionary:(NSDictionary *)dictionary{
    self.objectId = [dictionary objectForKey:@"objectId"];
    self.title = [dictionary objectForKey:@"title"];
    self.author = [dictionary objectForKey:@"author"];
    self.bookURL = [dictionary objectForKey:@"book_url"];
    self.coverURL = [dictionary objectForKey:@"cover_url"];
    self.summary = [dictionary objectForKey:@"description"];
    self.webURL = [dictionary objectForKey:@"web_url"];
    self.category = [dictionary objectForKey:@"category"];
    self.tags = [dictionary objectForKey:@"tags"];
    
    self.createdAt = [NSDate dateWithISO8601String:[dictionary objectForKey:@"createdAt"]];
    self.updatedAt = [NSDate dateWithISO8601String:[dictionary objectForKey:@"updatedAt"]];
}

-(void) retrieveDetail{
    if (![self isDetailDataLoaded]) {
        NSError *jsonError = nil;
        NSData *data = [PARNetworkManager retrieveObjectId:self.objectId forParseClass:@"Book"];
        NSDictionary *response = [NSJSONSerialization JSONObjectWithData:data
                                                                 options:kNilOptions
                                                                   error:&jsonError];
        [self updateModelWithJSONDictionary:response];
    }
}

-(void) freeUpMemory{
    // Caching is performed right after downloading resources
    self.image = nil;
    self.document = nil;
}

-(NSString *) cachePathForExtension:(NSString *)extension{
    NSString *cacheDir = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingString:@"/"];
    NSString *fileName = [self.title stringByReplacingOccurrencesOfString:@" " withString:@"_"];
    return [cacheDir stringByAppendingString:[fileName stringByAppendingString:extension]];
}

-(void) cacheImage{
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0), ^{
        [UIImagePNGRepresentation(self.image) writeToFile:[self cachePathForExtension:@".png"] atomically:YES];
    });
}

-(void) cachePDF:(NSData *) pdfFile{
    NSString *path = [self cachePathForExtension:@".pdf"];
    [pdfFile writeToFile:path atomically:YES];
}

-(void) downloadCoverImage:(void (^)())completionBlock{
    if (self.image != nil) {
        completionBlock();
    }else{
        // Trying to get the image from cacheDir
        self.image = [UIImage imageWithContentsOfFile:[self cachePathForExtension:@".png"]];
        if (self.image == nil) {
            __weak typeof(self) weakSelf = self;
            dispatch_async(dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0), ^{
                // QOS_CLASS_DEFAULT is the 3rd priority queue
                NSURL *coverURL = [NSURL URLWithString:self.coverURL];
                UIImage *coverImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:coverURL]];
                // image loading error
                if (coverImage == nil){
                    coverImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"oops" ofType:@".png"]];
                }else{
                    [self cacheImage];
                }
                weakSelf.image = coverImage;
                // Returning to main queue
                dispatch_async(dispatch_get_main_queue(), ^{
                    completionBlock();
                });
            });
        }else{
            completionBlock();
        }
    }
}

-(void) downloadBookPDF:(void (^)())completionBlock{
    if (self.document != nil) {
        completionBlock();
    }else{
        // Trying to get the image from cacheDir
        self.document = [[ReaderDocument alloc] initWithFilePath:[self cachePathForExtension:@".png"] password:nil];
        if (self.document == nil) {
            __weak typeof(self) weakSelf = self;
            dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INTERACTIVE, 0), ^{
                // QOS_CLASS_USER_INTERACTIVE is the 1st priority queue
                NSURL *bookURL = [NSURL URLWithString:self.bookURL];
                NSData *bookData = [NSData dataWithContentsOfURL:bookURL];
                [self cachePDF:bookData];
                weakSelf.document = [[ReaderDocument alloc] initWithFilePath:[self cachePathForExtension:@".pdf"] password:nil];
                // Returning to main queue
                dispatch_async(dispatch_get_main_queue(), ^{
                    completionBlock();
                });
            });
        }else{
            completionBlock();
        }
    }
}

@end
