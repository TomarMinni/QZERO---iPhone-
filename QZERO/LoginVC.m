//
//  LoginVC.m
//  QZERO
//
//  Created by BT on 7/14/15.
//  Copyright (c) 2015 Braintechnosys. All rights reserved.
//

#import "LoginVC.h"
#import "ServiceConnector.h"
#import "Constants.h"
#import "AppDelegate.h"
#import "DashboardVC.h"

@interface LoginVC ()<ServiceConnectorDelegate>
{
    CGSize screenSize;
    BOOL buttonChecked;
    BOOL accept_terms;
    NSString *buttonType;
}
@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    screenSize = [[UIScreen mainScreen] bounds].size;
    [self addButtons];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES];
}
- (IBAction)BackToMainView:(id)sender
{
    [self.navigationController popViewControllerAnimated:NO];
}
-(void)addButtons
{
    _UserBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, screenSize.width/2-1, 43)];
    [_UserBtn setBackgroundColor:[UIColor whiteColor]];
    [_UserBtn setTitle:@"User" forState:UIControlStateNormal];
    _UserBtn.titleLabel.font = [UIFont fontWithName:@"Roboto" size:13.0];
    [_UserBtn setTitleColor:[UIColor colorWithRed:213.0/255.0 green:19.0/255.0 blue:10.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [_UserBtn addTarget:self action:@selector(UserBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [_BtnBackGroundView addSubview:_UserBtn];
    
    _UserLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, _UserBtn.frame.size.height, screenSize.width/2-1, 4)];
    [_UserLabel setBackgroundColor:[UIColor colorWithRed:213.0/255.0 green:19.0/255.0 blue:10.0/255.0 alpha:1.0]];
    [_BtnBackGroundView addSubview:_UserLabel];
    [self CreateUserView];
    
    
    _SignUpBtn = [[UIButton alloc]initWithFrame:CGRectMake(_UserBtn.frame.origin.x+_UserBtn.frame.size.width+1, 0, screenSize.width/2-1, 43)];
    [_SignUpBtn setBackgroundColor:[UIColor whiteColor]];
    [_SignUpBtn setTitle:@"Sign Up" forState:UIControlStateNormal];
    _SignUpBtn.titleLabel.font = [UIFont fontWithName:@"Roboto" size:13.0];
    [_SignUpBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_SignUpBtn addTarget:self action:@selector(SignUpBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [_BtnBackGroundView addSubview:_SignUpBtn];
    
    _SignUpLabel = [[UILabel alloc]initWithFrame:CGRectMake(_UserBtn.frame.origin.x+_UserBtn.frame.size.width+1, _SignUpBtn.frame.size.height, screenSize.width/2-1, 4)];
    [_SignUpLabel setBackgroundColor:[UIColor colorWithRed:213.0/255.0 green:19.0/255.0 blue:10.0/255.0 alpha:1.0]];
    [_SignUpLabel setHidden:YES];
    [_BtnBackGroundView addSubview:_SignUpLabel];
}
-(void)UserBtnAction:(id)sender
{
    
    [_UserLabel setHidden:NO];
    [_SignUpLabel setHidden:YES];
    [_UserBtn setTitleColor:[UIColor colorWithRed:213.0/255.0 green:19.0/255.0 blue:10.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [_SignUpBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self CreateUserView];
    
}
-(void)SignUpBtnAction:(id)sender
{
    [_UserLabel setHidden:YES];
    [_SignUpLabel setHidden:NO];
    [_SignUpBtn setTitleColor:[UIColor colorWithRed:213.0/255.0 green:19.0/255.0 blue:10.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [_UserBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self createSignUpView];
    
}
-(void)CreateUserView
{
    [self removeAllSubViews];
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, _BtnBackGroundView.frame.origin.y+_BtnBackGroundView.frame.size.height, screenSize.width, screenSize.height-_BtnBackGroundView.frame.origin.y+_BtnBackGroundView.frame.size.height)];
    [self.view addSubview:_scrollView];
    
    _UserNameTextField = [[UITextField alloc]initWithFrame:CGRectMake(20, 10, screenSize.width-40, 32)];
    _UserNameTextField.placeholder = @"UserName";
    _UserNameTextField.font = [UIFont fontWithName:@"Roboto" size:15.0];
    _UserNameTextField.textAlignment = NSTextAlignmentCenter;
    _UserNameTextField.tag = 1;
    _UserNameTextField.delegate = self;
    _UserNameTextField.returnKeyType = UIReturnKeyNext;
    [_UserNameTextField setBackground:[UIImage imageNamed:@"textfieldImage.png"]];
    [_scrollView addSubview:_UserNameTextField];
    
    _PasswordTextField = [[UITextField alloc]initWithFrame:CGRectMake(20, _UserNameTextField.frame.origin.y+_UserNameTextField.frame.size.height+10, screenSize.width-40, 32)];
    _PasswordTextField.placeholder = @"Password";
    _PasswordTextField.font = [UIFont fontWithName:@"Roboto" size:15.0];
    _PasswordTextField.textAlignment = NSTextAlignmentCenter;
    _PasswordTextField.tag = 2;
    _PasswordTextField.delegate = self;
    _PasswordTextField.returnKeyType = UIReturnKeyDefault;
    [_PasswordTextField setBackground:[UIImage imageNamed:@"textfieldImage.png"]];
    [_scrollView addSubview:_PasswordTextField];
    
    _sendBtn = [[UIButton alloc]initWithFrame:CGRectMake(screenSize.width/2-50, _PasswordTextField.frame.origin.y+_PasswordTextField.frame.size.height+10, 100, 30)];
    _sendBtn.tag = 1;
    [_sendBtn setBackgroundImage:[UIImage imageNamed:@"button.png"] forState:UIControlStateNormal];
    [_sendBtn addTarget:self action:@selector(sendPressed:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_sendBtn];
}
-(void)createSignUpView
{
    [self removeAllSubViews];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, _BtnBackGroundView.frame.origin.y+_BtnBackGroundView.frame.size.height, screenSize.width, screenSize.height-_BtnBackGroundView.frame.origin.y+_BtnBackGroundView.frame.size.height)];
    [self.view addSubview:_scrollView];
    
    _FirstNameTextField = [[UITextField alloc]initWithFrame:CGRectMake(20, 10, screenSize.width-40, 32)];
    _FirstNameTextField.placeholder = @"First Name";
    _FirstNameTextField.font = [UIFont fontWithName:@"Roboto" size:15.0];
    _FirstNameTextField.textAlignment = NSTextAlignmentCenter;
    _FirstNameTextField.tag = 1;
    _FirstNameTextField.delegate = self;
    _FirstNameTextField.returnKeyType = UIReturnKeyNext;
    [_FirstNameTextField setBackground:[UIImage imageNamed:@"textfieldImage.png"]];
    [_scrollView addSubview:_FirstNameTextField];
    
    _LastNameTextField = [[UITextField alloc]initWithFrame:CGRectMake(20, _FirstNameTextField.frame.origin.y+_FirstNameTextField.frame.size.height+10, screenSize.width-40, 32)];
    _LastNameTextField.placeholder = @"Last Name";
    _LastNameTextField.font = [UIFont fontWithName:@"Roboto" size:15.0];
    _LastNameTextField.textAlignment = NSTextAlignmentCenter;
    _LastNameTextField.tag = 2;
    _LastNameTextField.delegate = self;
    _LastNameTextField.returnKeyType = UIReturnKeyNext;
    [_LastNameTextField setBackground:[UIImage imageNamed:@"textfieldImage.png"]];
    [_scrollView addSubview:_LastNameTextField];
    
    _EmailTextField = [[UITextField alloc]initWithFrame:CGRectMake(20, _LastNameTextField.frame.origin.y+_LastNameTextField.frame.size.height+10, screenSize.width-40, 32)];
    _EmailTextField.placeholder = @"Email";
    _EmailTextField.font = [UIFont fontWithName:@"Roboto" size:15.0];
    _EmailTextField.textAlignment = NSTextAlignmentCenter;
    _EmailTextField.tag = 3;
    _EmailTextField.delegate = self;
    _EmailTextField.returnKeyType = UIReturnKeyNext;
    _EmailTextField.keyboardType = UIKeyboardTypeEmailAddress;
    [_EmailTextField setBackground:[UIImage imageNamed:@"textfieldImage.png"]];
    [_scrollView addSubview:_EmailTextField];
    
    _regUserNameTextField = [[UITextField alloc]initWithFrame:CGRectMake(20, _EmailTextField.frame.origin.y+_EmailTextField.frame.size.height+10, screenSize.width-40, 32)];
    _regUserNameTextField.placeholder = @"UserName";
    _regUserNameTextField.font = [UIFont fontWithName:@"Roboto" size:15.0];
    _regUserNameTextField.textAlignment = NSTextAlignmentCenter;
    _regUserNameTextField.tag = 4;
    _regUserNameTextField.delegate = self;
    _regUserNameTextField.returnKeyType = UIReturnKeyNext;
    [_regUserNameTextField setBackground:[UIImage imageNamed:@"textfieldImage.png"]];
    [_scrollView addSubview:_regUserNameTextField];
    
    _regPasswordTextField = [[UITextField alloc]initWithFrame:CGRectMake(20, _regUserNameTextField.frame.origin.y+_regUserNameTextField.frame.size.height+10, screenSize.width-40, 32)];
    _regPasswordTextField.placeholder = @"Password";
    _regPasswordTextField.tag = 5;
    _regPasswordTextField.font = [UIFont fontWithName:@"Roboto" size:15.0];
    _regPasswordTextField.textAlignment = NSTextAlignmentCenter;
    _regPasswordTextField.delegate = self;
    _regPasswordTextField.returnKeyType = UIReturnKeyNext;
    [_regPasswordTextField setBackground:[UIImage imageNamed:@"textfieldImage.png"]];
    [_scrollView addSubview:_regPasswordTextField];
    
    _ConfirmPasswordTextField = [[UITextField alloc]initWithFrame:CGRectMake(20, _regPasswordTextField.frame.origin.y+_regPasswordTextField.frame.size.height+10, screenSize.width-40, 32)];
    _ConfirmPasswordTextField.placeholder = @"Confirm Password";
    _ConfirmPasswordTextField.tag = 6;
    _ConfirmPasswordTextField.font = [UIFont fontWithName:@"Roboto" size:15.0];
    _ConfirmPasswordTextField.textAlignment = NSTextAlignmentCenter;
    _ConfirmPasswordTextField.delegate = self;
    _ConfirmPasswordTextField.returnKeyType = UIReturnKeyDefault;
    [_ConfirmPasswordTextField setBackground:[UIImage imageNamed:@"textfieldImage.png"]];
    [_scrollView addSubview:_ConfirmPasswordTextField];
    
    _agreementBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, _ConfirmPasswordTextField.frame.origin.y+_ConfirmPasswordTextField.frame.size.height+10, 25, 25)];
    [_agreementBtn setImage:[UIImage imageNamed:@"box-unchecked.png"] forState:UIControlStateNormal];
    [_agreementBtn addTarget:self action:@selector(checkAgreement) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_agreementBtn];
    
    _agreementLabel = [[UILabel alloc]initWithFrame:CGRectMake(_agreementBtn.frame.origin.x+_agreementBtn.frame.size.width+10,_ConfirmPasswordTextField.frame.origin.y+_ConfirmPasswordTextField.frame.size.height+10,screenSize.width-_agreementBtn.frame.origin.x-40, 25)];
    [_agreementLabel setText:@"I accept the User Agreement"];
    _agreementLabel.font = [UIFont fontWithName:@"Roboto" size:15.0];
    [_scrollView addSubview:_agreementLabel];
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithAttributedString:_agreementLabel.attributedText];
    [text addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0,_agreementLabel.text.length)];
    [text addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:213.0/255.0 green:19.0/255.0 blue:10.0/255.0 alpha:1.0] range:NSMakeRange(_agreementLabel.text.length-14,14)];
    [_agreementLabel setAttributedText:text];
    
    _sendBtn = [[UIButton alloc]initWithFrame:CGRectMake(screenSize.width/2-50, _agreementBtn.frame.origin.y+_agreementBtn.frame.size.height+10, 100, 30)];
    [_sendBtn setBackgroundImage:[UIImage imageNamed:@"button.png"] forState:UIControlStateNormal];
    _sendBtn.tag = 2;
    [_scrollView addSubview:_sendBtn];
    [_sendBtn addTarget:self action:@selector(sendPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [_scrollView setContentSize:CGSizeMake(screenSize.width, _sendBtn.frame.origin.y+_sendBtn.frame.size.height+100)];
    
}
-(void)checkAgreement
{
    if (buttonChecked == YES)
    {
        [_agreementBtn setImage:[UIImage imageNamed:@"box-unchecked.png"] forState:UIControlStateNormal];
        buttonChecked = NO;
        _agreementBtn.selected = NO;
        accept_terms = false;
    }
    else
    {
        [_agreementBtn setImage:[UIImage imageNamed:@"box-check.png"] forState:UIControlStateNormal];
        buttonChecked = YES;
        _agreementBtn.selected = YES;
        accept_terms = true;
    }
}
#pragma mark UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if ([textField isEqual:_FirstNameTextField])
    {
        [_LastNameTextField becomeFirstResponder];
    }
    else if ([textField isEqual:_LastNameTextField])
    {
        [_EmailTextField becomeFirstResponder];
    }
    else if ([textField isEqual:_EmailTextField])
    {
        [_regUserNameTextField becomeFirstResponder];
    }
    else if ([textField isEqual:_regUserNameTextField])
    {
        [_regPasswordTextField becomeFirstResponder];
    }
    else if ([textField isEqual:_regPasswordTextField])
    {
        [_ConfirmPasswordTextField becomeFirstResponder];
    }
    else if ([textField isEqual:_ConfirmPasswordTextField])
    {
        [_ConfirmPasswordTextField resignFirstResponder];
    }
    else if ([textField isEqual:_UserNameTextField])
    {
        [_PasswordTextField becomeFirstResponder];
    }
    else if ([textField isEqual:_PasswordTextField])
    {
        [_PasswordTextField resignFirstResponder];
    }
    return YES;
    
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self animateTextField: textField up: YES];
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self animateTextField: textField up: NO];
}

- (void) animateTextField: (UITextField*) textField up: (BOOL) up
{
    int movementDistance = 0; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    if (textField.tag == 1)
    {
        movementDistance = 0;
    }
    if (textField.tag == 2)
    {
        movementDistance = 30;
    }
    if (textField.tag == 3)
    {
        movementDistance = 70;
    }
    if (textField.tag == 4)
    {
        movementDistance = 110;
    }
    if (textField.tag == 5)
    {
        movementDistance = 150;
    }
    if (textField.tag == 6)
    {
        movementDistance = 200;
    }
    
    int movement = (up ? -movementDistance : movementDistance);
    
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}
-(void)sendPressed:(id)sender
{
    if ([sender tag]==1)
    {
        [self LoggedIn];
        buttonType = @"Login";
    }
    if ([sender tag]==2)
    {
        [self SignUpMethod];
        buttonType = @"Register";
    }
}

-(void)LoggedIn
{
    if ([_UserNameTextField.text length]==0)
    {
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@" " message:@"Please enter your UserName." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alertView show];
    }
    else if ([_PasswordTextField.text length]==0)
    {
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@" " message:@"Please enter your Password." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alertView show];
    }
    else
    {
        if ([[AppDelegate Getdelegate] connectedToNetwork])
        {
            [[AppDelegate Getdelegate]showIndicator];
            NSMutableDictionary *parameterDict = [[NSMutableDictionary alloc]init];
            [parameterDict setObject:_UserNameTextField.text forKey:@"userName"];
            [parameterDict setObject:_PasswordTextField.text forKey:@"password"];
            NSData * JsonData =[NSJSONSerialization dataWithJSONObject:parameterDict options:NSJSONWritingPrettyPrinted error:nil];
            NSString * parameterJsonString= [[NSString alloc] initWithData:JsonData encoding:NSUTF8StringEncoding];
            
            NSString *urlString = [NSString stringWithFormat:@"%@%@",kContantApi,AccountLoginApi];
            ServiceConnector *service = [[ServiceConnector alloc]init];
            service.delegate = self;
            [service postDataToApi:parameterJsonString withURLString:urlString];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                            message:@"Internet Connection is not working. Please check your internet Connection."
                                                           delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            
            
        }
    }
}
-(void)SignUpMethod
{
  
    NSString *strongPass= @"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{6,}$";
    NSPredicate *regexTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", strongPass];
    
   NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    
    if ([_FirstNameTextField.text length]==0)
    {
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@" " message:@"Please enter your First Name." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alertView show];
    }
    else if ([_LastNameTextField.text length]==0)
    {
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@" " message:@"Please enter your Last Name." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alertView show];
    }
    else if  ([_EmailTextField.text length]==0)
    {
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@" " message:@"Please enter your Email." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alertView show];
    }
    else if ([_regUserNameTextField.text length]==0)
    {
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@" " message:@"Please enter your UserName." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alertView show];
    }
    else if  ([_regPasswordTextField.text length]==0)
    {
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@" " message:@"Please enter your Password." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alertView show];
    }
    else if ([_ConfirmPasswordTextField.text length]==0)
    {
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@" " message:@"Please confirm your Password." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alertView show];
    }
    else
    {
        if ([emailTest evaluateWithObject:_EmailTextField.text] == NO)
        {
            if(![_EmailTextField.text isEqualToString:@""])
            {
                UIAlertView *emailalert = [[UIAlertView alloc] initWithTitle:@" " message:@"Please Enter Valid Email." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [emailalert show];
            }
            
            
        }
        else if (([_regPasswordTextField.text length]<6) || ([_regPasswordTextField.text length]>100))
        {
            UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@" " message:@"Password must be at least 6 characters." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alertView show];
        }
        else if ([regexTest evaluateWithObject:_regPasswordTextField.text] == NO)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                            message:@"Please Ensure that you have at least one lower case letter, one upper case letter, one digit and one special character"
                                                           delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
        else if(![_ConfirmPasswordTextField.text isEqualToString:_regPasswordTextField.text])
        {
            UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@" " message:@"Password does not match." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alertView show];
        }
        else
        {
            if ([[AppDelegate Getdelegate] connectedToNetwork])
            {
                
                [[AppDelegate Getdelegate]showIndicator];
                NSString *acceptTermsConditions;
                if (accept_terms == true)
                {
                    acceptTermsConditions = @"true";
                }
                else
                {
                    acceptTermsConditions = @"false";
                }
                
                NSMutableDictionary *parameterDict = [[NSMutableDictionary alloc]init];
                [parameterDict setObject:_regUserNameTextField.text forKey:@"userName"];
                [parameterDict setObject:_FirstNameTextField.text forKey:@"firstName"];
                [parameterDict setObject:_LastNameTextField.text forKey:@"lastName"];
                [parameterDict setObject:_EmailTextField.text forKey:@"email"];
                [parameterDict setObject:_regPasswordTextField.text forKey:@"password"];
                [parameterDict setObject:_ConfirmPasswordTextField.text forKey:@"confirmPassword"];
                [parameterDict setObject:acceptTermsConditions forKey:@"accept_terms"];
                
                NSData * JsonData =[NSJSONSerialization dataWithJSONObject:parameterDict options:NSJSONWritingPrettyPrinted error:nil];
                NSString * parameterJsonString= [[NSString alloc] initWithData:JsonData encoding:NSUTF8StringEncoding];
                
                NSString *urlString = [NSString stringWithFormat:@"%@%@",kContantApi,AccountRegistrationApi];
                ServiceConnector *service = [[ServiceConnector alloc]init];
                service.delegate = self;
                [service postDataToApi:parameterJsonString withURLString:urlString];
            }
            
            else
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                                message:@"Internet Connection is not working. Please check your internet Connection."
                                                               delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                
                
            }
        }
    }
}

#pragma ServiceConnector Delegate Method
-(void)requestReturnedData:(NSData *)data
{
    [[AppDelegate Getdelegate]hideIndicator];
    if ([buttonType isEqualToString:@"Login"])
    {
        NSString *responseStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"response is %@",responseStr);
        DashboardVC *dashboard = (DashboardVC *)[self.storyboard instantiateViewControllerWithIdentifier:@"DashboardVC"];
        [self.navigationController pushViewController:dashboard animated:YES];
    }
    if ([buttonType isEqualToString:@"Register"])
    {
        NSString *responseStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"response is %@",responseStr);
        
    }
    
}

-(void)removeAllSubViews
{
    [_scrollView removeFromSuperview];
    [_UserNameTextField removeFromSuperview];
    [_PasswordTextField removeFromSuperview];
    [_FirstNameTextField removeFromSuperview];
    [_LastNameTextField removeFromSuperview];
    [_EmailTextField removeFromSuperview];
    [_regPasswordTextField removeFromSuperview];
    [_regUserNameTextField removeFromSuperview];
    [_ConfirmPasswordTextField removeFromSuperview];
    [_agreementLabel removeFromSuperview];
    [_agreementBtn removeFromSuperview];
    [_sendBtn removeFromSuperview];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
