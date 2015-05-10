//
//  PARLibraryViewControllerDelegate.h
//  StartupLibrary
//
//  Created by parejo on 10/5/15.
//  Copyright (c) 2015 PabloParejo. All rights reserved.
//

#ifndef StartupLibrary_PARLibraryViewControllerDelegate_h
#define StartupLibrary_PARLibraryViewControllerDelegate_h

#endif

@protocol PARLibraryViewControllerDelegate <NSObject>

@optional
- (void) libraryViewController:(UIViewController *) libraryVC
                 didSelectBook:(PARBook *) book;
@end
