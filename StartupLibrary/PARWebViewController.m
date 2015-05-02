//
//  PARWebViewController.m
//  StartupLibrary
//
//  Created by parejo on 1/5/15.
//  Copyright (c) 2015 PabloParejo. All rights reserved.
//

#import "PARWebViewController.h"

#define DEFAULT_TITLE @"Web"

@interface PARWebViewController () <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loading;
@property (weak, nonatomic) IBOutlet UIWebView *browser;

@property (nonatomic, strong) NSURL *url;

@end

@implementation PARWebViewController

- (id) initWithURL:(NSURL *) url title:(NSString *)title{
    if (self = [super init]) {
        _url = url;
        self.title = title;
    }
    return self;
}

- (id) initWithURL:(NSURL *) url{
    return [self initWithURL:url title:DEFAULT_TITLE];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.browser loadRequest:[NSURLRequest requestWithURL:self.url]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) webViewDidStartLoad:(UIWebView *)webView{
    [self.loading startAnimating];
}

-(void) webViewDidFinishLoad:(UIWebView *)webView{
    [self.loading stopAnimating];
}


@end
