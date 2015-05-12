//
//  WebsiteViewController.m
//  OVOFan
//
//  Created by Jordan Anderson on 4/30/15.
//  Copyright (c) 2015 Jordan Anderson. All rights reserved.
//

#import "WebsiteViewController.h"
#import <JGProgressHUD/JGProgressHUD.h>

@import WebKit;

@interface WebsiteViewController () <WKNavigationDelegate>
{
    JGProgressHUD *HUD;
}

//@property (strong, nonatomic) IBOutlet WKWebView *webView;
@property (strong, nonatomic) IBOutlet WKWebView *webView;

@end

@implementation WebsiteViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self JGShowLoadingHud];
    [self newsWebviewConfigure];
    
    if (self.webView)
    {
        [HUD dismissAfterDelay:2 animated:YES];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)newsWebviewConfigure
{
    WKWebViewConfiguration *theConfiguration = [[WKWebViewConfiguration alloc] init];
    self.webView = [[WKWebView alloc] initWithFrame:self.view.frame configuration:theConfiguration];
    self.webView.navigationDelegate = self;
    //    NSURL *nsurl=[NSURL URLWithString: webUrl];
    NSURLRequest *nsrequest = [NSURLRequest requestWithURL:self.anArticle.articleUrl];
    
    [self.webView loadRequest:nsrequest];
    [self.view insertSubview:self.webView atIndex:1];

//    [HUD dismissAfterDelay:2 animated:YES];

}

- (void)JGShowLoadingHud
{
    HUD = [JGProgressHUD progressHUDWithStyle:JGProgressHUDStyleDark];
    HUD.textLabel.text = @"Loading";
    [HUD showInView:self.view];
}


@end
