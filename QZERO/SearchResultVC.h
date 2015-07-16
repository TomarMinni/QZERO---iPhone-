//
//  SearchResultVC.h
//  QZERO
//
//  Created by BT on 7/15/15.
//  Copyright (c) 2015 Braintechnosys. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchResultVC : UIViewController
@property (strong, nonatomic) IBOutlet UITableView *searchResultTableView;
@property (strong, nonatomic) NSMutableArray *resultArray;
@property (strong, nonatomic) NSString *searchString;
@end
