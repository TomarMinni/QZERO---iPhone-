//
//  SearchVC.h
//  QZERO
//
//  Created by BT on 7/14/15.
//  Copyright (c) 2015 Braintechnosys. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchVC : UIViewController<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UIView *ButtonBackgroundView;
@property (strong, nonatomic) IBOutlet UIButton *VenueBtn;
@property (strong, nonatomic) IBOutlet UIButton *OutletBtn;
@property (strong, nonatomic) IBOutlet UIButton *ItemBtn;
@property (strong, nonatomic) IBOutlet UILabel *VenueLabel;
@property (strong, nonatomic) IBOutlet UILabel *OutletLabel;
@property (strong, nonatomic) IBOutlet UILabel *ItemLabel;

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UITextField *VenueTextField;
@property (strong, nonatomic) IBOutlet UITextField *CityTextField;
@property (strong, nonatomic) IBOutlet UITextField *ZipCodeTextField;
@property (strong, nonatomic) IBOutlet UITextField *NearestLocTextField;
@property (strong, nonatomic) IBOutlet UITextField *OutletTextField;
@property (strong, nonatomic) IBOutlet UITextField *ItemTextField;
@property (strong, nonatomic) IBOutlet UIButton *sendBtn;

@property (strong, nonatomic) UIWindow *window;


@end
