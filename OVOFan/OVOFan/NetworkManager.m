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
    
    NSString *accountKey;
    NSString *rootURL;
    NSString *fullURL;
    
    BOOL bingBool;

}

@end

@implementation NetworkManager

static NSString *mainSchedApiURL = @"https://www.kimonolabs.com/api/4b6j8tp8?apikey=AD4O0cRRulTPwjT2llph80hhqIU8QDtt";
static NSString *upcomingMatchApiURL = @"https://www.kimonolabs.com/api/7frwoxaw?apikey=AD4O0cRRulTPwjT2llph80hhqIU8QDtt";
static NSString *recentNewsApiURL = @"https://www.kimonolabs.com/api/ejewyfaw?apikey=AD4O0cRRulTPwjT2llph80hhqIU8QDtt";
static NSString *leagueStandingsApiURL = @"https://www.kimonolabs.com/api/6ok0l5mc?apikey=AD4O0cRRulTPwjT2llph80hhqIU8QDtt";
static NSString *teamApiURL = @"https://www.kimonolabs.com/api/5oe8yp4q?apikey=AD4O0cRRulTPwjT2llph80hhqIU8QDtt";

static NSString *clubStatsApiURL = @"https://www.kimonolabs.com/api/akd6qfh8?apikey=AD4O0cRRulTPwjT2llph80hhqIU8QDtt";

static NSString *clubStatsGoalsApiURL = @"https://www.kimonolabs.com/api/ei0ey1g8?apikey=AD4O0cRRulTPwjT2llph80hhqIU8QDtt";

static NSString *clubStatsAssistsApiURL = @"https://www.kimonolabs.com/api/8huac3sm?apikey=AD4O0cRRulTPwjT2llph80hhqIU8QDtt";
static NSString *clubStatsAttendanceApiURL = @"https://www.kimonolabs.com/api/4ezoeqhq?apikey=AD4O0cRRulTPwjT2llph80hhqIU8QDtt";

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

- (void)fetchLeagueStandings
{
    NSURL *url = [NSURL URLWithString:leagueStandingsApiURL];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url];
    [self startDataTask:dataTask];
}

- (void)fetchCurrentTeam
{
    NSURL *url = [NSURL URLWithString:teamApiURL];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url];
    [self startDataTask:dataTask];
}


- (void)fetchClubStatsGoals
{
    NSURL *url = [NSURL URLWithString:clubStatsGoalsApiURL];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url];
    [self startDataTask:dataTask];
}

- (void)fetchClubStatsAssists
{
    NSURL *url = [NSURL URLWithString:clubStatsAssistsApiURL];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url];
    [self startDataTask:dataTask];
}

- (void)fetchClubStatsAttendance
{
    NSURL *url = [NSURL URLWithString:clubStatsAttendanceApiURL];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url];
    [self startDataTask:dataTask];
}


//- (void)fetchClubStats
//{
//    NSURL *url = [NSURL URLWithString:clubStatsApiURL];
//    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url];
//    [self startDataTask:dataTask];
//}

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
    NSMutableData *receivedData2 = receivedDataDict[[NSNumber numberWithInteger:dataTask.taskIdentifier]];
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
        
//        if ([[aDictionary objectForKey:@"name"] isEqualToString:@"ovo-stats"])
//        {
//            
////            NSDictionary *results = [aDictionary objectForKey:@"results"];
//            
//            NSMutableArray *allStatsArray = [[NSMutableArray alloc] init];
//            
//            // attendance
//            NSMutableArray *attendanceObjectArray = [[NSMutableArray alloc] init];
//            Attendance *theAttendance = [Attendance attendanceStatsWithDictionary:aDictionary];
//            
//            [attendanceObjectArray addObject:theAttendance];
//            
//            // assists 
//
//            NSMutableArray *assistObjectsArray = [[NSMutableArray alloc] init];
//            
//            for (int i = 1; i < 5; i++)
//            {
//                Assists *assist = [Assists attendanceStatsWithDictionary:aDictionary dicToParse:i];
//
//                [assistObjectsArray addObject:assist];
//            }
//            
//            // goals
//            
//            NSMutableArray *goalObjectsArray = [[NSMutableArray alloc] init];
//            for (int i = 6; i < 9; i++)
//            {
//                Goals *goal = [Goals goalsStatsWithDictionary:aDictionary dicToParse:i];
//
//                [goalObjectsArray addObject:goal];
//                
//            }
//            
//            allStatsArray = [@[attendanceObjectArray, assistObjectsArray, goalObjectsArray] mutableCopy];
////            NSLog(@"big stats array: %@", allStatsArray);
//            
//            if (allStatsArray.count != 0)
//            {
//                [self.clubStatsdelegate clubStatsWasFound:allStatsArray];
//            }
//            
//        }
        
        if ([[aDictionary objectForKey:@"name"] isEqualToString:@"ovo-stats-goals"])
        {

            NSDictionary *results = [aDictionary objectForKey:@"results"];
            NSArray *goalsArray = [results objectForKey:@"ovo-stats-goals"];
            
            NSMutableArray *goalsObjectsArray = [[NSMutableArray alloc] init];
            
            for (int i = 0; i < goalsArray.count; i++)
            {
                Goals *goal = [Goals goalsStatsWithDictionary:aDictionary dicToParse:i];
                
                [goalsObjectsArray addObject:goal];
            }
            
            if (goalsObjectsArray.count != 0)
            {
                [self.clubStatsdelegate clubStatsGoalsWasFound:goalsObjectsArray];
            }
            
        }
        
        if ([[aDictionary objectForKey:@"name"] isEqualToString:@"ovo-stats-assist"])
        {
            
            NSDictionary *results = [aDictionary objectForKey:@"results"];
            NSArray *assistsArray = [results objectForKey:@"stats-assist"];
            
            NSMutableArray *assistObjectsArray = [[NSMutableArray alloc] init];
            
            for (int i = 0; i < assistsArray.count; i++)
            {
                Assists *assist = [Assists assistStatsWithDictionary:aDictionary dicToParse:i];
                
                [assistObjectsArray addObject:assist];
            }
            
            if (assistObjectsArray.count != 0)
            {
                [self.clubStatsdelegate clubStatsAssistsWasFound:assistObjectsArray];
            }
            
        }
        
        if ([[aDictionary objectForKey:@"name"] isEqualToString:@"ovo-stats-attendance"])
        {
            NSMutableArray *attendanceObjectsArray = [[NSMutableArray alloc] init];
            
            Attendance *attendance = [Attendance attendanceStatsWithDictionary:aDictionary];
                
            [attendanceObjectsArray addObject:attendance];
            
            
            if (attendanceObjectsArray.count != 0)
            {
                [self.clubStatsdelegate clubStatsAttendanceWasFound:attendanceObjectsArray];
            }
        
        }
        
        if ([[aDictionary objectForKey:@"name"] isEqualToString:@"ovo-squad"])
        {
            NSDictionary *results = [aDictionary objectForKey:@"results"];
            NSArray *squad = [results objectForKey:@"Squad"];
            
            NSMutableArray *playersObjectsArray = [[NSMutableArray alloc] init];
            
            for (int i = 0; i < squad.count; i++)
            {
                Team *aPlayer = [Team teamWithDictionary:aDictionary dicToParse:i];
                [playersObjectsArray addObject:aPlayer];
            }
            
            if (playersObjectsArray.count != 0)
            {
                [self.teamdelegate teamMembersWereFound:playersObjectsArray];
            }

        }
        
        
     

    }
    
}



@end
