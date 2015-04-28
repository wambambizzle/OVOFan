//
//  NetworkManager.m
//  OVOFan
//
//  Created by Jordan Anderson on 4/27/15.
//  Copyright (c) 2015 Jordan Anderson. All rights reserved.
//

#import "NetworkManager.h"

@interface NetworkManager () <NSURLSessionDataDelegate>
{
    NSURLSessionConfiguration *configuration;
    NSURLSession *session;
    NSMutableDictionary *receivedDataDict;
}

@end

@implementation NetworkManager

static NSString *mainSchedApiURL = @"https://www.kimonolabs.com/api/ondemand/4b6j8tp8";

+ (NetworkManager *)sharedNetworkManager //Singleton Method
{
    static NetworkManager *sharedNetworkManager = nil;
    if (sharedNetworkManager)
        return sharedNetworkManager;
    
    // Use Grand Central Dispatch to only init one instance of NetworkManager, makes the singleton thread-safe
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedNetworkManager = [[NetworkManager alloc] init];
    });
    
    return sharedNetworkManager;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:[NSOperationQueue mainQueue]];
        receivedDataDict = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}

- (void) grabTheSchedule
{
    NSURL *url = [NSURL URLWithString:mainSchedApiURL];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url];
    [self startDataTask:dataTask];
}

- (void)startDataTask:(NSURLSessionDataTask *)dataTask
{
    
     [receivedDataDict setObject:[[NSMutableData alloc] init] forKey:[NSNumber numberWithInteger:dataTask.taskIdentifier]];
     [dataTask resume];
}

#pragma mark - NSURLSession delegate

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler
{
    completionHandler(NSURLSessionResponseAllow);
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    NSMutableData *receivedData2 = receivedDataDict[[NSNumber numberWithInteger:dataTask.taskIdentifier]]; // <- like saying object for key
    [receivedData2 appendData:data];
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    if (!error)
    {
        NSMutableData *receivedData3 = receivedDataDict[[NSNumber numberWithInteger:task.taskIdentifier]];
        NSDictionary *aDictionary = [NSJSONSerialization JSONObjectWithData:receivedData3 options:0 error:nil];
        
        NSLog(@"%@", aDictionary);
//        City *aCity = citiesForActiveTasks[[NSNumber numberWithInteger:task.taskIdentifier]];
//        DataFetchType fetchType;
//        if ([aDictionary objectForKey:@"results"])
//        {
//            fetchType = DataFetchTypeCoordinates;
//        }
//        else
//        {
//            fetchType = DataFetchTypeWeather;
//        }
//        BOOL coordinatesSuccess = NO;
//        BOOL weatherSuccess = NO;
//        switch (fetchType)
//        {
//            case DataFetchTypeCoordinates:
//                coordinatesSuccess = [aCity parseCoordinateInfo:aDictionary];
//                break;
//            case DataFetchTypeWeather:
//                weatherSuccess = [aCity.currentWeather parseWeatherInfo:aDictionary];
//                break;
//                
//            default:
//                break;
//        }
//        
//        if (coordinatesSuccess)
//        {
//            [self.delegate cityWasFound:aCity];
//        }
//        if (weatherSuccess)
//        {
//            [self.delegate weatherWasFoundForCity:aCity];
//        }
    }
    
}



@end
