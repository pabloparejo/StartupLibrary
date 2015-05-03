//
//  PARLibrary.m
//  StartupLibrary
//
//  Created by parejo on 2/5/15.
//  Copyright (c) 2015 PabloParejo. All rights reserved.
//

#import "PARLibrary.h"

#define JSON_URL @"http://www.mocky.io/v2/5544e9cd9da4c21d1429b11f"

@interface PARLibrary()

@property (nonatomic, copy) NSDictionary *library;

@end

@implementation PARLibrary

-(id) init{
    if (self = [super init]) {
        [self createLibraryWithBooks:[self downloadBooks]];
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

- (NSArray *) downloadBooks{
    NSURL *url = [NSURL URLWithString:JSON_URL];
    
    NSError *jsonError = nil;
    NSArray *JSONbooks = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfURL:url] options:kNilOptions error:&jsonError];
    
    NSMutableArray *books = [NSMutableArray array];
    
    [JSONbooks enumerateObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
        [books addObject:[[PARBook alloc] initWithJSONDictionary:obj]];
    }];
    
    return books;
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
