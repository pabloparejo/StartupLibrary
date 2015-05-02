//
//  PARLibrary.m
//  StartupLibrary
//
//  Created by parejo on 2/5/15.
//  Copyright (c) 2015 PabloParejo. All rights reserved.
//

#import "PARLibrary.h"

@interface PARLibrary()

@property (nonatomic, copy) NSDictionary *library;

@end

@implementation PARLibrary

-(id) init{
    if (self = [super init]) {
        [self createLibraryWithBooks:[self generateBooks]];
    }
    return self;
}

- (void) createLibraryWithBooks:(NSArray *) books{
    NSMutableDictionary *categoriesDict = [NSMutableDictionary dictionary];
    
    // Order books by category (NSDictionary keys)
    [books enumerateObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(PARBook *book, NSUInteger idx, BOOL *stop) {
        if ([categoriesDict objectForKey:book.category] == nil) {
            [categoriesDict setObject:[NSMutableArray arrayWithObject:book] forKey:book.category];
        }else{
            [[categoriesDict objectForKey:book.category] addObject:book];
        }
    }];

    // We make model immutable
    [categoriesDict enumerateKeysAndObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(NSString *key, NSMutableArray *array, BOOL *stop) {
        [categoriesDict setObject:[array copy] forKey:key];
    }];
    _library = [categoriesDict copy];
}

- (NSArray *) generateBooks{
    PARBook *first = [PARBook bookWithTitle:@"Test-Driven Development with Python"
                                     author:@"Harry Percival"
                                    bookURL:[NSURL URLWithString:@"http://cdn2.filepi.com/g/fxiypq5/1430560276/001f0d881952cccc289ac97cf10a6182"]
                                   coverURL:[NSURL URLWithString:@"http://hackershelf.com/media/cache/49/94/4994a9500689d5b1483c50b6ab9c7975.jpg"]
                                    summary:@"Test-Driven Development with Python focuses on web development, with some coverage of JavaScript (inescapable for any web programmer). This book uses a concrete example—the development of a website, from scratch—to teach the TDD metholology, and how it applies to web programming, from the basics of database integration and javascript, going via browser-automation tools like Selenium, to advanced (and trendy) topics like NoSQL, websockets and Async programming."
                                     webURL:[NSURL URLWithString:@"http://chimera.labs.oreilly.com/books/1234000000754/index.html"]
                                   category:@"Methodology"
                                       tags:@[@"test", @"python", @"selenium", @"django", @"test", @"driven", @"development"]];
    PARBook *second = [PARBook bookWithTitle:@"Learning Cocoa with Objective-C"
                                      author:@"James Duncan Davidson"
                                     bookURL:[NSURL URLWithString:@"http://cdn3.filepi.com/g/k70Tmk9/1430560341/975470c7ac47b94def0f0cac98066b60"]
                                    coverURL:[NSURL URLWithString:@"http://it-ebooks.info/images/ebooks/3/learning_cocoa_with_objective-c_3rd_edition.jpg"]
                                     summary:@"Get up to speed on Cocoa and Objective-C, and start developing applications on the iOS and OS X platforms. If you don't have experience with Apple's developer tools, no problem! From object-oriented programming to storing app data in iCloud, this book covers everything you need to build apps for the iPhone, iPad, and Mac. You'll learn how to work with the Xcode IDE, Objective-C's Foundation library, and other developer tools such as Event Kit framework and Core Animation. Along the way, you'll build example projects, including a simple Objective-C application, a custom view, a simple video player application, and an app that displays calendar events for the user."
                                      webURL:[NSURL URLWithString:@"http://commons.oreilly.com/wiki/index.php/Learning_Cocoa_with_Objective-C"]
                                    category:@"Cocoa"
                                        tags:@[@"cocoa",@"objective-c",@"macOSX",@"iOS"]];

    
    PARBook *third = [PARBook bookWithTitle:@"Pro Git"
                                      author:@"Scott Chacon"
                                     bookURL:[NSURL URLWithString:@"https://progit2.s3.amazonaws.com/en/2015-04-22-540e8/progit-en.457.pdf"]
                                    coverURL:[NSURL URLWithString:@"http://hackershelf.com/media/cache/ec/87/ec87afb1068d1993b543e2a4eb4ebd6f.jpg"]
                                     summary:@"Git is the version control system developed by Linus Torvalds for Linux kernel development. It took the open source world by storm since its inception in 2005, and is used by small development shops and giants like Google, Red Hat, and IBM, and of course many open source projects. A book by Git experts to turn you into a Git expert"
                                      webURL:[NSURL URLWithString:@"http://progit.org/book/"]
                                    category:@"Version Control"
                                        tags:@[@"version control", @"git"]];

    return @[first, second, third];
}


# pragma mark - Data Source

-(NSUInteger)countForKey:(NSString *)key{
    return [[self.library objectForKey:key] count];
}
-(NSString *)keyForSection:(NSUInteger)section{
    return [[self.library allKeys] objectAtIndex:section];
}
-(NSUInteger)numberOfSections{
    return [[self.library allKeys]count];
}
-(NSArray *) booksForKey:(NSString *)key{
    return [self.library objectForKey:key];
}
-(PARBook *) bookForKey:(NSString *)key atIndex:(NSUInteger) index{
    return [[self.library objectForKey:key] objectAtIndex:index];
}
@end
