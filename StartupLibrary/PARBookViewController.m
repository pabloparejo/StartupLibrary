//
//  BookViewController.m
//  StartupLibrary
//
//  Created by parejo on 1/5/15.
//  Copyright (c) 2015 PabloParejo. All rights reserved.
//

#import "PARBookViewController.h"
#import "PARWebViewController.h"

#define BUY_BOOK_TITLE @"Book's Store"

@interface PARBookViewController ()

@property (strong, nonatomic) PARBook *model;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *author;
@property (weak, nonatomic) IBOutlet UIButton *category;
@property (weak, nonatomic) IBOutlet UILabel *summary;
@property (weak, nonatomic) IBOutlet UIImageView *bookImage;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loading;

@end

@implementation PARBookViewController

- (id) initWithModel:(PARBook *)model{
    if (self = [super init]) {
        _model = model;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.model withCoverImage:^(UIImage *image) {
        [self.bookImage setImage:image];
        [self.loading stopAnimating];
    }];
    
    self.titleLabel.text = [self.model title];
    self.author.text = [self.model author];
    self.summary.text = [self.model summary];
    self.title = [self.model title];
    [self.category setTitle:[self.model category] forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBActions


- (IBAction)openBook:(id)sender {
    NSLog(@"%@", [self.model bookURL]);
    PARWebViewController *webVC = [[PARWebViewController alloc] initWithURL:[self.model bookURL]];
    [self.navigationController pushViewController:webVC animated:YES];
}

- (IBAction)buyBook:(id)sender {
    NSLog(@"%@", [self.model webURL]);
    PARWebViewController *webVC = [[PARWebViewController alloc] initWithURL:[self.model webURL] title:BUY_BOOK_TITLE];
    [self.navigationController pushViewController:webVC animated:YES];
}



@end
