//
//  ProductReusableView.h
//  chineseStore
//
//  Created by Pablo Parejo Camacho on 3/5/15.
//  Copyright (c) 2015 Pablo Parejo Camacho. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PARBookCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loading;

@end
