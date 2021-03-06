//
//  PlayerWebViewController.m
//  OVOFan
//
//  Created by Jordan Anderson on 5/1/15.
//  Copyright (c) 2015 Jordan Anderson. All rights reserved.
//

#import "PlayerWebViewController.h"
#import <JGProgressHUD/JGProgressHUD.h>

@import WebKit;

@interface PlayerWebViewController () <WKNavigationDelegate>
{
    JGProgressHUD *HUD;
}

@property (strong, nonatomic) IBOutlet WKWebView *webView;

@end

@implementation PlayerWebViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIFont fontWithName:@"HelveticaNeue-Light" size:20],
      NSFontAttributeName,
      [UIColor whiteColor],NSForegroundColorAttributeName, nil]];
    
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
    
    [self JGShowLoadingHud];
    [self playerDetailsWebViewConfigure];
    
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

- (void)playerDetailsWebViewConfigure
{
    WKWebViewConfiguration *theConfiguration = [[WKWebViewConfiguration alloc] init];
    self.webView = [[WKWebView alloc] initWithFrame:self.view.frame configuration:theConfiguration];
    self.webView.navigationDelegate = self;
    
    NSURL *theNsurl = [NSURL URLWithString:self.aPlayer.detailsLink];
    NSURLRequest *nsrequest = [NSURLRequest requestWithURL: theNsurl];
    
    [self.webView loadRequest:nsrequest];
    [self.view insertSubview:self.webView atIndex:1];
}

- (void)JGShowLoadingHud
{
    HUD = [JGProgressHUD progressHUDWithStyle:JGProgressHUDStyleDark];
    HUD.textLabel.text = @"Loading";
    [HUD showInView:self.view];
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
