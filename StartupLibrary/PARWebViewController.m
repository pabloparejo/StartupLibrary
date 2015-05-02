//
//  PARWebViewController.m
//  StartupLibrary
//
//  Created by parejo on 1/5/15.
//  Copyright (c) 2015 PabloParejo. All rights reserved.
//

#import "PARWebViewController.h"

@interface PARWebViewController () <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loading;
@property (weak, nonatomic) IBOutlet UIWebView *browser;

@property (nonatomic, strong) NSURL *url;

@end

@implementation PARWebViewController

- (id) initWithURL:(NSURL *) url{
    if (self = [super init]) {
        _url = url;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.browser loadRequest:[NSURLRequest requestWithURL:self.url]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) webViewDidFinishLoad:(UIWebView *)webView{
    [self.loading stopAnimating];
}


@end
