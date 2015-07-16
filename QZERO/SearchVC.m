//
//  SearchVC.m
//  QZERO
//
//  Created by BT on 7/14/15.
//  Copyright (c) 2015 Braintechnosys. All rights reserved.
//

#import "SearchVC.h"
#import "ServiceConnector.h"
#import "Constants.h"
#import "AppDelegate.h"
#import "SearchResultVC.h"
#import "JSONDictionaryExtensions.h"

@interface SearchVC ()<ServiceConnectorDelegate>
{
    CGSize screenSize;
    NSString *searchType;
}

@end

@implementation SearchVC

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
-(void)addButtons
{
    _VenueBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, screenSize.width/3-1, 43)];
    [_VenueBtn setBackgroundColor:[UIColor whiteColor]];
    [_VenueBtn setTitle:@"Venue" forState:UIControlStateNormal];
    _VenueBtn.titleLabel.font = [UIFont fontWithName:@"Roboto" size:13.0];
    [_VenueBtn setTitleColor:[UIColor colorWithRed:213.0/255.0 green:19.0/255.0 blue:10.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [_VenueBtn addTarget:self action:@selector(VenueBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [_ButtonBackgroundView addSubview:_VenueBtn];
    
    _VenueLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, _VenueBtn.frame.size.height, screenSize.width/3-1, 4)];
    [_VenueLabel setBackgroundColor:[UIColor colorWithRed:213.0/255.0 green:19.0/255.0 blue:10.0/255.0 alpha:1.0]];
    [_ButtonBackgroundView addSubview:_VenueLabel];
    [self CreateVenueView];
    
    _OutletBtn = [[UIButton alloc]initWithFrame:CGRectMake(_VenueBtn.frame.origin.x+_VenueBtn.frame.size.width+1, 0, screenSize.width/3-1, 43)];
    [_OutletBtn setBackgroundColor:[UIColor whiteColor]];
    [_OutletBtn setTitle:@"Outlet" forState:UIControlStateNormal];
     _OutletBtn.titleLabel.font = [UIFont fontWithName:@"Roboto" size:13.0];
    [_OutletBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_OutletBtn addTarget:self action:@selector(OutletBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [_ButtonBackgroundView addSubview:_OutletBtn];
    
    _OutletLabel = [[UILabel alloc]initWithFrame:CGRectMake(_VenueBtn.frame.origin.x+_VenueBtn.frame.size.width+1, _OutletBtn.frame.size.height, screenSize.width/3-1, 4)];
    [_OutletLabel setBackgroundColor:[UIColor colorWithRed:213.0/255.0 green:19.0/255.0 blue:10.0/255.0 alpha:1.0]];
    [_OutletLabel setHidden:YES];
    [_ButtonBackgroundView addSubview:_OutletLabel];
    
    _ItemBtn = [[UIButton alloc]initWithFrame:CGRectMake(_OutletBtn.frame.origin.x+_OutletBtn.frame.size.width+1, 0, screenSize.width/3-1, 43)];
    [_ItemBtn setBackgroundColor:[UIColor whiteColor]];
    [_ItemBtn setTitle:@"Item" forState:UIControlStateNormal];
     _ItemBtn.titleLabel.font = [UIFont fontWithName:@"Roboto" size:13.0];
    [_ItemBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_ItemBtn addTarget:self action:@selector(ItemBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [_ButtonBackgroundView addSubview:_ItemBtn];
    
    _ItemLabel = [[UILabel alloc]initWithFrame:CGRectMake(_OutletBtn.frame.origin.x+_OutletBtn.frame.size.width+1, _ItemBtn.frame.size.height, screenSize.width/3-1, 4)];
    [_ItemLabel setBackgroundColor:[UIColor colorWithRed:213.0/255.0 green:19.0/255.0 blue:10.0/255.0 alpha:1.0]];
    [_ItemLabel setHidden:YES];
    [_ButtonBackgroundView addSubview:_ItemLabel];

    
}
-(void)VenueBtnAction:(id)sender
{
    [_VenueLabel setHidden:NO];
    [_OutletLabel setHidden:YES];
    [_ItemLabel setHidden:YES];
    [_VenueBtn setTitleColor:[UIColor colorWithRed:213.0/255.0 green:19.0/255.0 blue:10.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [_OutletBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_ItemBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self CreateVenueView];
}
-(void)OutletBtnAction:(id)sender
{
    [_VenueLabel setHidden:YES];
    [_OutletLabel setHidden:NO];
    [_ItemLabel setHidden:YES];
    [_VenueBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_OutletBtn setTitleColor:[UIColor colorWithRed:213.0/255.0 green:19.0/255.0 blue:10.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [_ItemBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self CreateOutletView];


}
-(void)ItemBtnAction:(id)sender
{
    [_VenueLabel setHidden:YES];
    [_OutletLabel setHidden:YES];
    [_ItemLabel setHidden:NO];
    [_VenueBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_OutletBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_ItemBtn setTitleColor:[UIColor colorWithRed:213.0/255.0 green:19.0/255.0 blue:10.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [self CreateItemView];

}
-(void)CreateVenueView
{
  
     [self removeAllSubViews];
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, _ButtonBackgroundView.frame.origin.y+_ButtonBackgroundView.frame.size.height, screenSize.width, screenSize.height-_ButtonBackgroundView.frame.origin.y+_ButtonBackgroundView.frame.size.height)];
    [self.view addSubview:_scrollView];
    
    _VenueTextField = [[UITextField alloc]initWithFrame:CGRectMake(20, 10, screenSize.width-40, 32)];
    _VenueTextField.placeholder = @"Venue";
     _VenueTextField.font = [UIFont fontWithName:@"Roboto" size:15.0];
    _VenueTextField.textAlignment = NSTextAlignmentCenter;
    _VenueTextField.tag = 1;
     _VenueTextField.returnKeyType = UIReturnKeyNext;
    [_VenueTextField setBackground:[UIImage imageNamed:@"textfieldImage.png"]];
    _VenueTextField.delegate = self;
    [_scrollView addSubview:_VenueTextField];
    
    _CityTextField = [[UITextField alloc]initWithFrame:CGRectMake(20, _VenueTextField.frame.origin.y+_VenueTextField.frame.size.height+10, screenSize.width-40, 32)];
    _CityTextField.placeholder = @"City";
    _CityTextField.font = [UIFont fontWithName:@"Roboto" size:15.0];
    _CityTextField.textAlignment = NSTextAlignmentCenter;
    _CityTextField.tag = 2;
     _CityTextField.delegate = self;
     _CityTextField.returnKeyType = UIReturnKeyNext;
    [_CityTextField setBackground:[UIImage imageNamed:@"textfieldImage.png"]];
    [_scrollView addSubview:_CityTextField];
    
    _ZipCodeTextField = [[UITextField alloc]initWithFrame:CGRectMake(20, _CityTextField.frame.origin.y+_CityTextField.frame.size.height+10, screenSize.width-40, 32)];
    _ZipCodeTextField.placeholder = @"ZipCode";
    _ZipCodeTextField.font = [UIFont fontWithName:@"Roboto" size:15.0];
    _ZipCodeTextField.textAlignment = NSTextAlignmentCenter;
    _ZipCodeTextField.tag = 3;
    _ZipCodeTextField.delegate = self;
     _ZipCodeTextField.returnKeyType = UIReturnKeyNext;
    [_ZipCodeTextField setBackground:[UIImage imageNamed:@"textfieldImage.png"]];
    [_scrollView addSubview:_ZipCodeTextField];
    
    _NearestLocTextField = [[UITextField alloc]initWithFrame:CGRectMake(20, _ZipCodeTextField.frame.origin.y+_ZipCodeTextField.frame.size.height+10, screenSize.width-40, 32)];
    _NearestLocTextField.placeholder = @"Nearest Location";
    _NearestLocTextField.font = [UIFont fontWithName:@"Roboto" size:15.0];
    _NearestLocTextField.textAlignment = NSTextAlignmentCenter;
    _NearestLocTextField.tag = 4;
    _NearestLocTextField.delegate = self;
     _NearestLocTextField.returnKeyType = UIReturnKeyDefault;
    [_NearestLocTextField setBackground:[UIImage imageNamed:@"textfieldImage.png"]];
    [_scrollView addSubview:_NearestLocTextField];
    
    _sendBtn = [[UIButton alloc]initWithFrame:CGRectMake(screenSize.width/2-50, _NearestLocTextField.frame.origin.y+_NearestLocTextField.frame.size.height+10, 100, 30)];
    _sendBtn.tag = 1;
    [_sendBtn setBackgroundImage:[UIImage imageNamed:@"button.png"] forState:UIControlStateNormal];
    [_sendBtn addTarget:self action:@selector(sendPressed:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_sendBtn];

}

-(void)CreateOutletView
{
     [self removeAllSubViews];
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, _ButtonBackgroundView.frame.origin.y+_ButtonBackgroundView.frame.size.height, screenSize.width, screenSize.height-_ButtonBackgroundView.frame.origin.y+_ButtonBackgroundView.frame.size.height)];
    [self.view addSubview:_scrollView];
    
    _OutletTextField = [[UITextField alloc]initWithFrame:CGRectMake(20, 10, screenSize.width-40, 32)];
    _OutletTextField.placeholder = @"Outlet";
    _OutletTextField.font = [UIFont fontWithName:@"Roboto" size:15.0];
    _OutletTextField.textAlignment = NSTextAlignmentCenter;
    _OutletTextField.tag = 1;
    _OutletTextField.delegate = self;
     _OutletTextField.returnKeyType = UIReturnKeyNext;
    [_OutletTextField setBackground:[UIImage imageNamed:@"textfieldImage.png"]];
    [_scrollView addSubview:_OutletTextField];
    
    _CityTextField = [[UITextField alloc]initWithFrame:CGRectMake(20, _VenueTextField.frame.origin.y+_VenueTextField.frame.size.height+10, screenSize.width-40, 32)];
    _CityTextField.placeholder = @"City";
    _CityTextField.font = [UIFont fontWithName:@"Roboto" size:15.0];
    _CityTextField.textAlignment = NSTextAlignmentCenter;
     _CityTextField.tag = 2;
    _CityTextField.delegate = self;
     _CityTextField.returnKeyType = UIReturnKeyNext;
    [_CityTextField setBackground:[UIImage imageNamed:@"textfieldImage.png"]];
    [_scrollView addSubview:_CityTextField];
    
    _ZipCodeTextField = [[UITextField alloc]initWithFrame:CGRectMake(20, _CityTextField.frame.origin.y+_CityTextField.frame.size.height+10, screenSize.width-40, 32)];
    _ZipCodeTextField.placeholder = @"ZipCode";
    _ZipCodeTextField.font = [UIFont fontWithName:@"Roboto" size:15.0];
    _ZipCodeTextField.textAlignment = NSTextAlignmentCenter;
    _ZipCodeTextField.tag = 3;
    _ZipCodeTextField.delegate = self;
     _ZipCodeTextField.returnKeyType = UIReturnKeyNext;
     [_ZipCodeTextField setBackground:[UIImage imageNamed:@"textfieldImage.png"]];
    [_scrollView addSubview:_ZipCodeTextField];
    
    _NearestLocTextField = [[UITextField alloc]initWithFrame:CGRectMake(20, _ZipCodeTextField.frame.origin.y+_ZipCodeTextField.frame.size.height+10, screenSize.width-40, 32)];
    _NearestLocTextField.placeholder = @"Nearest Location";
    _NearestLocTextField.font = [UIFont fontWithName:@"Roboto" size:15.0];
    _NearestLocTextField.textAlignment = NSTextAlignmentCenter;
    _NearestLocTextField.tag = 4;
    _NearestLocTextField.delegate = self;
     _NearestLocTextField.returnKeyType = UIReturnKeyDefault;
    [_NearestLocTextField setBackground:[UIImage imageNamed:@"textfieldImage.png"]];
    [_scrollView addSubview:_NearestLocTextField];
    
    _sendBtn = [[UIButton alloc]initWithFrame:CGRectMake(screenSize.width/2-50, _NearestLocTextField.frame.origin.y+_NearestLocTextField.frame.size.height+10, 100, 30)];
    _sendBtn.tag = 2;
    [_sendBtn setBackgroundImage:[UIImage imageNamed:@"button.png"] forState:UIControlStateNormal];
     [_sendBtn addTarget:self action:@selector(sendPressed:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_sendBtn];

}
-(void)CreateItemView
{
    [self removeAllSubViews];
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, _ButtonBackgroundView.frame.origin.y+_ButtonBackgroundView.frame.size.height, screenSize.width, screenSize.height-_ButtonBackgroundView.frame.origin.y+_ButtonBackgroundView.frame.size.height)];
    [self.view addSubview:_scrollView];
    
    _ItemTextField = [[UITextField alloc]initWithFrame:CGRectMake(20, 10, screenSize.width-40, 32)];
    _ItemTextField.placeholder = @"Item";
    _ItemTextField.font = [UIFont fontWithName:@"Roboto" size:15.0];
    _ItemTextField.textAlignment = NSTextAlignmentCenter;
    _ItemTextField.tag = 1;
    _ItemTextField.delegate = self;
     _ItemTextField.returnKeyType = UIReturnKeyDefault;
    [_ItemTextField setBackground:[UIImage imageNamed:@"textfieldImage.png"]];
    [_scrollView addSubview:_ItemTextField];
    
    _sendBtn = [[UIButton alloc]initWithFrame:CGRectMake(screenSize.width/2-50, _ItemTextField.frame.origin.y+_ItemTextField.frame.size.height+10, 100, 30)];
    _sendBtn.tag = 3;
    [_sendBtn setBackgroundImage:[UIImage imageNamed:@"button.png"] forState:UIControlStateNormal];
     [_sendBtn addTarget:self action:@selector(sendPressed:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_sendBtn];

}
#pragma mark UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if (([textField isEqual:_VenueTextField]) || ([textField isEqual:_OutletTextField]))
    {
        [_CityTextField becomeFirstResponder];
    }
    else if ([textField isEqual:_CityTextField])
    {
        [_ZipCodeTextField becomeFirstResponder];
    }
    else if ([textField isEqual:_ZipCodeTextField])
    {
        [_NearestLocTextField becomeFirstResponder];
    }
    else if ([textField isEqual:_NearestLocTextField])
    {
        [_NearestLocTextField resignFirstResponder];
    }
    else if([textField isEqual:_ItemTextField])
    {
        [_ItemTextField resignFirstResponder];
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
        movementDistance = 0;
    }
    if (textField.tag == 3)
    {
        movementDistance = 30;
    }
    if (textField.tag == 4)
    {
        movementDistance = 60;
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
        [self searchVenue];
    }
    if ([sender tag]==2)
    {
        [self searchOutlet];
    }
    if ([sender tag]==3)
    {
        [self searchItem];
    }
}

-(void)searchVenue
{
    if ([[AppDelegate Getdelegate] connectedToNetwork])
    {
        [[AppDelegate Getdelegate]showIndicator];
        NSString *urlString = [NSString stringWithFormat:@"%@%@?restaurantName=%@&city=%@&zipCode=%@&nearestLocation=%@",kContantApi,SearchVenueApi,_VenueTextField.text,_CityTextField.text,_ZipCodeTextField.text,_NearestLocTextField.text];
        searchType = @"Venue";
        ServiceConnector *service = [[ServiceConnector alloc]init];
        service.delegate = self;
        [service getDataFromApi:urlString];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                        message:@"Internet Connection is not working. Please check your internet Connection."
                                                       delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];

    }
    
}
-(void)searchOutlet
{
    NSLog(@"search outlet");
    if ([[AppDelegate Getdelegate] connectedToNetwork])
    {
        [[AppDelegate Getdelegate]showIndicator];
        NSString *urlString = [NSString stringWithFormat:@"%@%@?restaurantName=%@&city=%@&zipCode=%@&nearestLocation=%@",kContantApi,SearchOutletApi,_OutletTextField.text,_CityTextField.text,_ZipCodeTextField.text,_NearestLocTextField.text];
        searchType = @"Outlet";
        ServiceConnector *service = [[ServiceConnector alloc]init];
        service.delegate = self;
        [service getDataFromApi:urlString];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                        message:@"Internet Connection is not working. Please check your internet Connection."
                                                       delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];

    }
}
-(void)searchItem
{
    if ([[AppDelegate Getdelegate] connectedToNetwork])
    {
        [[AppDelegate Getdelegate]showIndicator];
        NSString *urlString = [NSString stringWithFormat:@"%@%@?itemName=%@",kContantApi,SearchItemApi,_ItemTextField.text];
        searchType = @"Item";
        ServiceConnector *service = [[ServiceConnector alloc]init];
        service.delegate = self;
        [service getDataFromApi:urlString];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                        message:@"Internet Connection is not working. Please check your internet Connection."
                                                       delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];

    }
}

#pragma ServiceConnector Delegate Method
-(void)requestReturnedData:(NSData *)data
{
    [[AppDelegate Getdelegate]hideIndicator];
    NSString *responseStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"response is %@",responseStr);
    NSDictionary *dictionary = [NSDictionary dictionaryWithJSONData:data];
    SearchResultVC *search = (SearchResultVC *)[self.storyboard instantiateViewControllerWithIdentifier:@"SearchResultVC"];
    search.resultArray = [dictionary objectForKey:@"result"];
    search.searchString = searchType;
    [self.navigationController pushViewController:search animated:YES];

}
-(void)removeAllSubViews
{
    [_scrollView removeFromSuperview];
    [_VenueTextField removeFromSuperview];
    [_CityTextField removeFromSuperview];
    [_ZipCodeTextField removeFromSuperview];
    [_NearestLocTextField removeFromSuperview];
    [_OutletTextField removeFromSuperview];
    [_ItemTextField removeFromSuperview];
    [_sendBtn removeFromSuperview];
}
- (IBAction)BackToMainView:(id)sender
{
    [self.navigationController popViewControllerAnimated:NO];
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
