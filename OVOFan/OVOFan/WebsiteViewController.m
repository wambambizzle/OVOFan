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

@interface WebsiteViewController () <WKNavigationDelegate, WKUIDelegate>
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
//    else if (!self.webView)
//    {
//       self.title = @"ERROR: Failed to load page";
//    }
    
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

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)())completionHandler
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:message
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK"
                                                        style:UIAlertActionStyleCancel
                                                      handler:^(UIAlertAction *action) {
                                                          completionHandler();
                                                      }]];
    [self presentViewController:alertController animated:YES completion:^{}];
}

//- (void)wkwebviewDidError
//{
//    [HUD dismissAnimated:YES];
//    NSString *alertTitle = @"Network Error. Check Signal Strength or Wifi Connectivitiy";
//    NSString *alertMessage = @"Click Retry to try again";
//    
//    UIAlertController *alertController = [UIAlertController
//                                          alertControllerWithTitle:alertTitle
//                                          message:alertMessage
//                                          preferredStyle:UIAlertControllerStyleAlert];
//    
//    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
//                                                     handler:^(UIAlertAction *action) {
//                                                         
//                                                         
//                                                     }];
//    
//    UIAlertAction *retryAction = [UIAlertAction actionWithTitle:@"Retry" style:UIAlertActionStyleDefault
//                                                        handler:^(UIAlertAction *action) {
//                                                            
//                                                            [self newsWebviewConfigure];
//                                                            
//                                                        }];
//    [alertController addAction:okAction];
//    [alertController addAction:retryAction];
//    
//    [self presentViewController:alertController animated:YES completion:nil];
// 
//}


@end
