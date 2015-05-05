//
//  HomeCollectionViewController.m
//  OVOFan
//
//  Created by Jordan Anderson on 5/5/15.
//  Copyright (c) 2015 Jordan Anderson. All rights reserved.
//

#import "HomeCollectionViewController.h"

#import "HomeCollectionViewCell.h"

@interface HomeCollectionViewController ()
{
    NSArray *navImages;
    NSArray *navDescriptions;
}


@end

@implementation HomeCollectionViewController

static NSString * const reuseIdentifier = @"NavCell";

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    navImages = [NSArray arrayWithObjects:[UIImage imageNamed:@"calendar.png"],
                  [UIImage imageNamed:@"bus.png"],
                  [UIImage imageNamed:@"newspaper.png"],
                  [UIImage imageNamed:@"trophy.png"],
                  [UIImage imageNamed:@"clubstats.png"],
                  [UIImage imageNamed:@"team.png"], nil];
    
    navDescriptions = @[@"Schedule", @"Shuttle", @"News", @"League Standings", @"Club Stats", @"Team"];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
//    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{

    return navImages.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.naviImage.image = navImages[indexPath.row];
    cell.naviLabel.text = navDescriptions[indexPath.row];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/


// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}


/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
