//
//  WebsiteViewController.m
//  OVOFan
//
//  Created by Jordan Anderson on 4/30/15.
//  Copyright (c) 2015 Jordan Anderson. All rights reserved.
//

#import "WebsiteViewController.h"

@import WebKit;

@interface WebsiteViewController () <WKNavigationDelegate>

//@property (strong, nonatomic) IBOutlet WKWebView *webView;
@property (strong, nonatomic) IBOutlet WKWebView *webView;

@end

@implementation WebsiteViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    WKWebViewConfiguration *theConfiguration = [[WKWebViewConfiguration alloc] init];
    self.webView = [[WKWebView alloc] initWithFrame:self.view.frame configuration:theConfiguration];
    self.webView.navigationDelegate = self;
//    NSURL *nsurl=[NSURL URLWithString: webUrl];
    NSURLRequest *nsrequest=[NSURLRequest requestWithURL:self.anArticle.articleUrl];

    [self.webView loadRequest:nsrequest];
    [self.view addSubview:self.webView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
