//
//  BingSearch.m
//  OVOFan
//
//  Created by Jordan Anderson on 5/3/15.
//  Copyright (c) 2015 Jordan Anderson. All rights reserved.
//

#import "BingSearch.h"

@interface BingSearch () <NSURLSessionDataDelegate>
{
    NSMutableData *receivedData;
}

@property NSString *accountKey;
@property NSString *rootUrl;
@property NSString *fullUrl;

@end

@implementation BingSearch

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _accountKey = @"yFPI0Ijp55ibaYc2Mj2OahxDBeFnrCCnLvicm2DqHHQ=";
        _rootUrl = @"https://api.datamarket.azure.com/Bing/Search/";
//        _articleTitle = articleTitle;
//        _articleDescription = articleDescription;
//        _articleUrl = articleUrl;
//        _source = source;
//        _date = date;
        
        //        yFPI0Ijp55ibaYc2Mj2OahxDBeFnrCCnLvicm2DqHHQ=  made one
        //        uU7jIa1gQhNsJmCcPLJQUEzs4tVNiVQ+VswDptyjFOQ default
    }
    
    return self;
}


- (void)bingNewsSearch
{
    NSString *queryString = @"Orlando City Soccer Club";
    
    NSString *format = @"json";
    
    NSString *market = @"'en-us'";
    
    NSInteger top = 8;
    
    NSMutableString *fullUri = [NSMutableString stringWithCapacity:256];
    
    [fullUri appendString:_rootUrl];

    [fullUri appendFormat:@"News?$format=%@", format];
    
    [fullUri appendFormat:@"&Query='%@'", [queryString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    [fullUri appendFormat:@"&Market=%@", [market stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    [fullUri appendFormat:@"&$top=%ld", (long)top];
    
    [self bingSave:fullUri];
    
}

-(void)bingSave:(NSString *)urlStrg
{
    
    NSURL *url = [NSURL URLWithString:urlStrg];
    //    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //  NSData *responseDate = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    //    NSDictionary *userInfo = [NSJSONSerialization JSONObjectWithData:responseDate options:NSJSONReadingMutableContainers error:nil];
    //    [self.friends addObject:userInfo];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSString *authStr = [NSString stringWithFormat:@"%@:%@", _accountKey, _accountKey];
    
    NSData *authData = [authStr dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString *authValue = [NSString stringWithFormat:@"Basic %@",[authData base64EncodedStringWithOptions:0]];
    configuration.HTTPAdditionalHeaders = @{@"Authorization":authValue};
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url];
    
    [dataTask resume];
    
    //    [self cancel];
}

+ (instancetype)newsArticleWithDictionary:(NSDictionary *)newsDictionary dicToParse:(int)i
{
    {
        BingSearch *theArticle = [[BingSearch alloc] init];
    
        NSDictionary *dDict = [newsDictionary objectForKey:@"d"];
        
        NSArray *results = [dDict objectForKey:@"results"];
        NSDictionary *recentNewsDict = [results objectAtIndex:i];
        
        NSString *linkString = [recentNewsDict objectForKey:@"Url"];
        theArticle.articleUrl = [NSURL URLWithString:linkString];
        
        theArticle.articleTitle = [recentNewsDict objectForKey:@"Title"];
        theArticle.articleDescription = [recentNewsDict objectForKey:@"Description"];
        theArticle.source = [recentNewsDict objectForKey:@"Source"];
        theArticle.date = [recentNewsDict objectForKey:@"Date"];
        
        return theArticle;
    }
}

#pragma mark - NSURLSession delegate

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler
{
    completionHandler(NSURLSessionResponseAllow);
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    if (!receivedData)
    {
        receivedData = [[NSMutableData alloc] initWithData:data];
    }
    else
    {
        [receivedData setLength:0]; // AYY BENNNNN
        [receivedData appendData:data];
    }
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    if (!error)
    {
//        NSLog(@"Download Successful");

        NSDictionary *aDictionary = [NSJSONSerialization JSONObjectWithData:receivedData options:0 error:nil];
        
        NSDictionary *dDict = [aDictionary objectForKey:@"d"];

        NSArray *results = [dDict objectForKey:@"results"];
//        NSLog(@"%@", results);
        
        NSMutableArray *newsArticlesArray = [[NSMutableArray alloc] init];
        
        for (int i = 0; i < results.count; i++)
        {
            BingSearch *anArticle = [BingSearch newsArticleWithDictionary:aDictionary dicToParse:i];
            
            [newsArticlesArray addObject:anArticle];
        }
        
        if (newsArticlesArray.count != 0)
        {
            [self.newsdelegate recentNewsWasFound:newsArticlesArray];
        }
        
    }
    
        //    NSDictionary *recentNewsDict = [recentNews objectAtIndex:i];

    if (error)
    {
        NSDictionary *errorDic = @{@"error": error};
        [[NSNotificationCenter defaultCenter] postNotificationName:@"showWithError" object:nil userInfo:errorDic];
    }
    
}
    





@end
