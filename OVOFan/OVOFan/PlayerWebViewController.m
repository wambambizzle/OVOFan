//
//  PlayerWebViewController.m
//  OVOFan
//
//  Created by Jordan Anderson on 5/1/15.
//  Copyright (c) 2015 Jordan Anderson. All rights reserved.
//

#import "PlayerWebViewController.h"

@import WebKit;

@interface PlayerWebViewController () <WKNavigationDelegate>

@property (strong, nonatomic) IBOutlet WKWebView *webView;

@end

@implementation PlayerWebViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSArray *nameParts = [self.aPlayer.name componentsSeparatedByString:@" "];
    if (![self.aPlayer.name containsString:@" "])
    {
        NSString *lastName = nameParts[0];
        self.title = lastName;

    }
    else if (nameParts.count == 2)
    {
        NSString *lastName = nameParts[1];
        self.title = lastName;
    }
    else if (nameParts.count == 3)
    {
        NSString *lastName = [NSString stringWithFormat:@"%@ %@", nameParts[1], nameParts[2]];
        self.title = lastName; 
    }

    WKWebViewConfiguration *theConfiguration = [[WKWebViewConfiguration alloc] init];
    self.webView = [[WKWebView alloc] initWithFrame:self.view.frame configuration:theConfiguration];
    self.webView.navigationDelegate = self;
    
    NSURL *theNsurl = [NSURL URLWithString:self.aPlayer.detailsLink];
    NSURLRequest *nsrequest = [NSURLRequest requestWithURL: theNsurl];
    
    [self.webView loadRequest:nsrequest];
    [self.view addSubview:self.webView];
}

- (void)didReceiveMemoryWarning
{
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
