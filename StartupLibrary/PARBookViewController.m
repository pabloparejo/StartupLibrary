//
//  BookViewController.m
//  StartupLibrary
//
//  Created by parejo on 1/5/15.
//  Copyright (c) 2015 PabloParejo. All rights reserved.
//

#import "PARBookViewController.h"
#import "PARBook.h"

@interface PARBookViewController ()

@property (strong, nonatomic) PARBook *model;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *author;

@end

@implementation PARBookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.model  = [PARBook bookWithTitle:@"Test-Driven Development with Python"
                                  author:@"Harry Percival"
                                 bookURL:[NSURL URLWithString:@"http://filepi.com/i/fxiypq5"]
                                coverURL:[NSURL URLWithString:@"http://hackershelf.com/media/cache/49/94/4994a9500689d5b1483c50b6ab9c7975.jpg"]
                                 summary:@"Test-Driven Development with Python focuses on web development, with some coverage of JavaScript (inescapable for any web programmer). This book uses a concrete example—the development of a website, from scratch—to teach the TDD metholology, and how it applies to web programming, from the basics of database integration and javascript, going via browser-automation tools like Selenium, to advanced (and trendy) topics like NoSQL, websockets and Async programming."
                                  webURL:[NSURL URLWithString:@"http://chimera.labs.oreilly.com/books/1234000000754/index.html"]
                                category:@"Metodology"
                                    tags:@[@"test", @"python", @"selenium", @"django", @"test", @"driven", @"development"]];
    
    self.titleLabel.text = [self.model title];
    self.author.text = [self.model author];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
