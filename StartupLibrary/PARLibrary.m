//
//  PARLibrary.m
//  StartupLibrary
//
//  Created by parejo on 2/5/15.
//  Copyright (c) 2015 PabloParejo. All rights reserved.
//

#import "PARLibrary.h"
#import "PARBook.h"
#import "PARNetworkManager.h"
#import "ParseSettings.h"
#import "NSDate+Formatters.h"

@implementation PARLibrary

+ (void) fetchBooksWithContext:(NSManagedObjectContext *)context{
    
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"PARBook"];
    request.sortDescriptors = @[[[NSSortDescriptor alloc] initWithKey:@"updatedAt" ascending:NO]];
    
    NSError *jsonError = nil;
    NSArray *results = [context executeFetchRequest:request error:nil];
    NSData *data;
    if ([results count]) {
        PARBook *lastBook = [results firstObject];
        data = [PARNetworkManager listParseClass:PARSE_CLASS_BOOK
                                                fromDate:[lastBook updatedAt]];
    }else{
        data = [PARNetworkManager listParseClass:PARSE_CLASS_BOOK];
    }
    if (data) {
        NSDictionary *response = [NSJSONSerialization JSONObjectWithData:data
                                                                 options:kNilOptions
                                                                   error:&jsonError];
        NSArray *booksJSON = [response objectForKey:@"results"];
        [self updateLibraryWithJSONArray:booksJSON context:context];
    }
}

+ (void) updateLibraryWithJSONArray:(NSArray *)array context:(NSManagedObjectContext *) context{
    [array enumerateObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
        NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"PARBook"];
        NSPredicate *predicate =[NSPredicate predicateWithFormat:@"objectId == %@", [obj objectForKey:@"objectId"]];
        [request setPredicate:predicate];
        NSArray *results = [context executeFetchRequest:request error:nil];
        if ([results count]) {
            [[results objectAtIndex:0] updateModelWithJSONDictionary:obj];
        }else{
            [PARBook bookWithContext:context dictionary:obj];
        }
    }];
}
@end
