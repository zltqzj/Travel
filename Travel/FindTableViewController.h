//
//  FindTableViewController.h
//  Travel
//
//  Created by ZKR on 1/7/15.
//  Copyright (c) 2015 ZKR. All rights reserved.
//

#import <UIKit/UIKit.h>
 
@interface FindTableViewController : UITableViewController <UICollectionViewDelegate,UICollectionViewDataSource>

@property(weak,nonatomic) IBOutlet UICollectionView* collectionView;
@property(strong,nonatomic) NSArray* imageArray;
@property(strong,nonatomic) NSArray* descArray;
//@property(weak,nonatomic) IBOutlet MTBlockTableView* diaryTable;

@end
