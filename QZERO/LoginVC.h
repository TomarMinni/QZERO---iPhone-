//
//  LoginVC.h
//  QZERO
//
//  Created by BT on 7/14/15.
//  Copyright (c) 2015 Braintechnosys. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginVC : UIViewController<UIScrollViewDelegate,UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UIView *BtnBackGroundView;
@property (strong, nonatomic) IBOutlet UIButton *UserBtn;
@property (strong, nonatomic) IBOutlet UIButton *SignUpBtn;
@property (strong, nonatomic) IBOutlet UILabel *UserLabel;
@property (strong, nonatomic) IBOutlet UILabel *SignUpLabel;

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UITextField *UserNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *PasswordTextField;
@property (strong, nonatomic) IBOutlet UITextField *FirstNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *LastNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *EmailTextField;
@property (strong, nonatomic) IBOutlet UITextField *regPasswordTextField;
@property (strong, nonatomic) IBOutlet UITextField *regUserNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *ConfirmPasswordTextField;
@property (strong, nonatomic) IBOutlet UILabel  *agreementLabel;
@property (strong, nonatomic) IBOutlet UIButton *agreementBtn;
@property (strong, nonatomic) IBOutlet UIButton *sendBtn;


@end
