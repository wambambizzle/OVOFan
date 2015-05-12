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
    NSURLRequest *nsrequest = [NSURLRequest requestWithURL:self.anArticle.articleUrl];

    [self.webView loadRequest:nsrequest];
    [self.view addSubview:self.webView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//#pragma mark - NSNotificantion Center Error
//
//-(void)showWithError:(NSNotification *)errorNotification
//{
//    NSError *error = [errorNotification.userInfo objectForKey:@"error"];
//    
//    NSString *alertTitle = [NSString stringWithFormat:@"%@", [error localizedDescription]];
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
//
//                                                            
//                                                        }];
//    [alertController addAction:okAction];
//    [alertController addAction:retryAction];
//    
//    [self presentViewController:alertController animated:YES completion:nil];
//    
//}


@end
