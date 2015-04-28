//
//  NetworkManager.m
//  OVOFan
//
//  Created by Jordan Anderson on 4/27/15.
//  Copyright (c) 2015 Jordan Anderson. All rights reserved.
//

#import "NetworkManager.h"

typedef enum
{
    DataFetchTypeSchedule,
    DataFetchTypeUpcomingGame,
} DataFetchType;

@interface NetworkManager () <NSURLSessionDataDelegate>
{
    NSURLSessionConfiguration *configuration;
    NSURLSession *session;
    NSMutableDictionary *receivedDataDict;
}

@end

@implementation NetworkManager

static NSString *mainSchedApiURL = @"https://www.kimonolabs.com/api/ondemand/4b6j8tp8";
static NSString *upcomingMatchApiURL = @"https://www.kimonolabs.com/api/ondemand/7frwoxaw";

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

- (void)fetchTheSchedule
{
    NSURL *url = [NSURL URLWithString:mainSchedApiURL];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url];
    [self startDataTask:dataTask];
}

- (void)fetchTheUpcomingMatch
{
    NSURL *url = [NSURL URLWithString:upcomingMatchApiURL];
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
        
        BOOL nextMatchFound = NO;
        
        if ([[aDictionary objectForKey:@"name"] isEqualToString:@"Upcoming Game"])
            {
                UpcomingMatch *upComingMatch = [[UpcomingMatch alloc] init];
               nextMatchFound = [upComingMatch parseupComingMatchInfo:aDictionary];
                if (nextMatchFound)
                {
                    [self.delegate nextMatchWasFound:upComingMatch];
                }
            }
        
        
        
        
//        NSLog(@"%@", aDictionary);
//        DataFetchType fetchType;
//        if ([[aDictionary objectForKey:@"name"] isEqualToString:@"Upcoming Game"])
//        {
//            fetchType = DataFetchTypeUpcomingGame;
//        }
//        else
//        {
//            fetchType = DataFetchTypeSchedule;
//        }
//        BOOL coordinatesSuccess = NO;
//        BOOL weatherSuccess = NO;
//        switch (fetchType)
//        {
//            case DataFetchTypeUpcomingGame:
//                coordinatesSuccess = [aCity parseCoordinateInfo:aDictionary];
//                break;
//            case DataFetchTypeSchedule:
//                weatherSuccess = [aCity.currentWeather parseWeatherInfo:aDictionary];
//                break;
//                
//            default:
//                break;
//        }
        
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
