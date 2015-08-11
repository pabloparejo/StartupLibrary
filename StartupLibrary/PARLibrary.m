//
//  PARLibrary.m
//  StartupLibrary
//
//  Created by parejo on 2/5/15.
//  Copyright (c) 2015 PabloParejo. All rights reserved.
//

#import "PARLibrary.h"
#import "PARNetworkManager.h"

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
    [books enumerateObjectsUsingBlock:^(PARBook *book, NSUInteger idx, BOOL *stop) {
        /*  Could this block be concurrent?
            Sometimes I'm getting this error: EXC_BAD_ACCESS code=1
            I think it's because the array of a category is not yet fully created
         */
        if ([categoriesDict objectForKey:book.category] != nil) {
            [[categoriesDict objectForKey:book.category] addObject:book];
        }else{
            [categoriesDict setObject:[NSMutableArray arrayWithObject:book] forKey:book.category];
        }
    }];

    // We make model immutable
    [categoriesDict enumerateKeysAndObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(NSString *key, NSMutableArray *array, BOOL *stop) {
        [categoriesDict setObject:[array copy] forKey:key];
    }];
    _library = [categoriesDict copy];
}

- (NSArray *) downloadBooks{

    NSError *jsonError = nil;
    NSData *data = [PARNetworkManager listParseClass:@"Book"];
    NSDictionary *response = [NSJSONSerialization JSONObjectWithData:data
                                                             options:kNilOptions
                                                               error:&jsonError];
    NSArray *booksJSON = [response objectForKey:@"results"];
    
    NSMutableArray *books = [NSMutableArray array];
    
    [booksJSON enumerateObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
        [books addObject:[[PARBook alloc] initWithJSONDictionary:obj]];
    }];
    
    return books;
}


-(void) freeUpMemory{
    [self.library enumerateKeysAndObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(NSString *key, NSArray *books, BOOL *stop) {
        [books enumerateObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(PARBook *book, NSUInteger idx, BOOL *stop) {
            [book freeUpMemory];
        }];
    }];
}

-(NSString *)keyForSection:(NSUInteger)section{
    return [[self.library allKeys] objectAtIndex:section];
}

# pragma mark - Data Source

-(NSUInteger)countForSection:(NSUInteger)section{
    return [[self.library objectForKey:[self keyForSection:section]] count];
}

-(NSString *)titleForSection:(NSUInteger)section{
    return [self keyForSection:section];
}

-(NSUInteger)numberOfSections{
    return [[self.library allKeys]count];
}
-(NSArray *) booksForSection:(NSUInteger)section{
    return [self.library objectForKey:[self keyForSection:section]];
}
-(PARBook *) bookAtIndexPath:(NSIndexPath*)indexPath{
    return [[self.library objectForKey:[self keyForSection:indexPath.section]] objectAtIndex:indexPath.row];
}
@end
