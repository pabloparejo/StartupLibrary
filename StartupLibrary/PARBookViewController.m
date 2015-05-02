//
//  BookViewController.m
//  StartupLibrary
//
//  Created by parejo on 1/5/15.
//  Copyright (c) 2015 PabloParejo. All rights reserved.
//

#import "PARBookViewController.h"
#import "PARBook.h"
#import "PARWebViewController.h"
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

- (void)viewDidLoad {
    [super viewDidLoad];
    self.model  = [PARBook bookWithTitle:@"Test-Driven Development with Python"
                                  author:@"Harry Percival"
                                 bookURL:[NSURL URLWithString:@"http://cdn2.filepi.com/g/fxiypq5/1430560276/001f0d881952cccc289ac97cf10a6182"]
                                coverURL:[NSURL URLWithString:@"http://hackershelf.com/media/cache/49/94/4994a9500689d5b1483c50b6ab9c7975.jpg"]
                                 summary:@"Test-Driven Development with Python focuses on web development, with some coverage of JavaScript (inescapable for any web programmer). This book uses a concrete example—the development of a website, from scratch—to teach the TDD metholology, and how it applies to web programming, from the basics of database integration and javascript, going via browser-automation tools like Selenium, to advanced (and trendy) topics like NoSQL, websockets and Async programming."
                                  webURL:[NSURL URLWithString:@"http://chimera.labs.oreilly.com/books/1234000000754/index.html"]
                                category:@"Metodology"
                                    tags:@[@"test", @"python", @"selenium", @"django", @"test", @"driven", @"development"]];
    
    

    [self downloadImageFromUrl:[self.model coverURL] complete:^(UIImage *image) {
        [self.bookImage setImage:image];
        [self.loading stopAnimating];
    }];
    
    self.titleLabel.text = [self.model title];
    self.author.text = [self.model author];
    [self.category setTitle:[self.model category] forState:UIControlStateNormal];
    self.summary.text = [self.model summary];
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
    PARWebViewController *webVC = [[PARWebViewController alloc] initWithURL:[self.model webURL]];
    [self.navigationController pushViewController:webVC animated:YES];
}

#pragma mark - Utils

-(void)downloadImageFromUrl:(NSURL *)url complete:(void (^)(UIImage *image))completionBlock{

    dispatch_async(dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0), ^{
        // QOS_CLASS_DEFAULT is the 3rd priority queue
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
        
        // Returning to main queue
        dispatch_async(dispatch_get_main_queue(), ^{
            completionBlock(image);
        });
    });
    
}

@end
