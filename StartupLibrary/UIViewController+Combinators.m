//
//  UIViewController+Combinators.m
//  StartupLibrary
//
//  Created by parejo on 2/5/15.
//  Copyright (c) 2015 PabloParejo. All rights reserved.
//

#import "UIViewController+Combinators.h"

@implementation UIViewController (Combinators)

-(UINavigationController *) wrappedInNavigationController{
    return [[UINavigationController alloc] initWithRootViewController:self];
}

@end
