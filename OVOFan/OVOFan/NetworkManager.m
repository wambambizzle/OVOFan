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

static NSString *mainSchedApiURL = @"https://www.kimonolabs.com/api/4b6j8tp8?apikey=AD4O0cRRulTPwjT2llph80hhqIU8QDtt";
static NSString *upcomingMatchApiURL = @"https://www.kimonolabs.com/api/7frwoxaw?apikey=AD4O0cRRulTPwjT2llph80hhqIU8QDtt";
static NSString *recentNewsApiURL = @"https://www.kimonolabs.com/api/ejewyfaw?apikey=AD4O0cRRulTPwjT2llph80hhqIU8QDtt";
static NSString *leagueStandingsApiURL = @"https://www.kimonolabs.com/api/6ok0l5mc?apikey=AD4O0cRRulTPwjT2llph80hhqIU8QDtt";

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

- (void)fetchRecentNewsArticles
{
    NSURL *url = [NSURL URLWithString:recentNewsApiURL];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url];
    [self startDataTask:dataTask];
}

- (void)fetchLeagueStandings
{
    NSURL *url = [NSURL URLWithString:leagueStandingsApiURL];
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
        
        BOOL upcomingMatchFound = NO;
        
        if ([[aDictionary objectForKey:@"name"] isEqualToString:@"Upcoming Game"])
            {
                UpcomingMatch *upComingMatch = [[UpcomingMatch alloc] init];
               upcomingMatchFound = [upComingMatch parseupComingMatchInfo:aDictionary];
                
                if (upcomingMatchFound)
                {
                    [self.delegate nextMatchWasFound:upComingMatch];
                }
            }
        
        if ([[aDictionary objectForKey:@"name"] isEqualToString:@"ovo - recent news"])
        {
            
            NSDictionary *results = [aDictionary objectForKey:@"results"];
            NSArray *recentNews = [results objectForKey:@"Recent News"];
            
            NSMutableArray *newsObjectsArray = [[NSMutableArray alloc] init];

            for (int i = 0; i < recentNews.count; i++)
            {
                News *news = [News newsArticleWithDictionary:aDictionary dicToParse:i];

                [newsObjectsArray addObject:news];
            }
            
            if (newsObjectsArray.count != 0)
            {
                [self.newsdelegate recentNewsWasFound:newsObjectsArray];
            }
            
        }
        
        if ([[aDictionary objectForKey:@"name"] isEqualToString:@"ovo-leaguestandings"])
        {
            NSDictionary *results = [aDictionary objectForKey:@"results"];
            NSArray *rankings = [results objectForKey:@"rankings"];
            
            NSMutableArray *rankingObjectsArray = [[NSMutableArray alloc] init];
            
            for (int i = 0; i < rankings.count; i++)
            {
                Rankings *rank = [Rankings leagueStandingWithDictionary:aDictionary dicToParse:i];
                
                [rankingObjectsArray addObject:rank];
//                NSLog(@"%@", rankingObjectsArray);
            }
            
            if (rankingObjectsArray.count != 0)
            {
                [self.leagueStandingsdelegate recentStandingsWasFound:rankingObjectsArray];
            }
            
            
            
        }
        
        
     

    }
    
}



@end
