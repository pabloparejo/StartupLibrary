//
//  PARNetworkManager.h
//  StartupLibrary
//
//  Created by parejo on 7/8/15.
//  Copyright (c) 2015 PabloParejo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PARNetworkManager : NSObject

+ (NSData *) listParseClass: (NSString *) parseClass;
+ (NSData *) retrieveObjectId:(NSUInteger) objectId forParseClass: (NSString *) parseClass;

@end
