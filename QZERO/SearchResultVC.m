//
//  SearchResultVC.m
//  QZERO
//
//  Created by BT on 7/15/15.
//  Copyright (c) 2015 Braintechnosys. All rights reserved.
//

#import "SearchResultVC.h"

@interface SearchResultVC ()
{
    UILabel *headerLabel;
    UIImageView *backGroundImg;
    UILabel *venueLabel;
    UIImageView *addressImage;
    UILabel *addressLabel;
    UIImageView *phoneImage;
    UILabel *phoneLabel;
    UIImageView *mobileImage;
    UILabel *mobileLabel;
    NSMutableArray *searchResultArray;
    UIButton *backButton;
    UIButton *menuButton;
    CGSize screenSize;
  
    
}

@end

@implementation SearchResultVC

- (void)viewDidLoad {
   
    [super viewDidLoad];
    screenSize = [[UIScreen mainScreen] bounds].size;
    searchResultArray = [[NSMutableArray alloc]init];
    headerLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
    headerLabel.font = [UIFont fontWithName:@"Roboto" size:18];
    headerLabel.textColor =  [UIColor colorWithRed:136.0/255.0 green:56.0/255.0 blue:55.0/255.0 alpha:1.0];
    _searchResultTableView.tableHeaderView = headerLabel;
    
    if ([self.searchString isEqualToString:@"Venue"])
    {
        headerLabel.text = @"Venue Details";
        for (int i = 0; i<[self.resultArray count]; i++)
        {
            NSString *locString = [NSString stringWithFormat:@"%@",[[self.resultArray objectAtIndex:i] objectForKey:@"address"]];
            NSString *cityString = [NSString stringWithFormat:@"%@",[[self.resultArray objectAtIndex:i] objectForKey:@"city"]];
            NSString *zipString = [NSString stringWithFormat:@"%@",[[self.resultArray objectAtIndex:i] objectForKey:@"zipcode"]];
            NSString *addressString = [NSString stringWithFormat:@"%@,%@,%@",locString,cityString,zipString];
            [searchResultArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%@",[[self.resultArray objectAtIndex:i] objectForKey:@"venueName"]],@"searchTypeName",addressString,@"address",[NSString stringWithFormat:@"%@",[[self.resultArray objectAtIndex:i] objectForKey:@"mobileNo"]],@"mobileNo",[NSString stringWithFormat:@"%@",[[self.resultArray objectAtIndex:i] objectForKey:@"phoneNo"]],@"phoneNo", nil]];
        }
    }
    if ([self.searchString isEqualToString:@"Outlet"])
    {
      headerLabel.text = @"Outlet Details";
      for (int i = 0; i<[self.resultArray count]; i++)
      {
        NSString *locString = [NSString stringWithFormat:@"%@",[[self.resultArray objectAtIndex:i] objectForKey:@"address"]];
        NSString *cityString = [NSString stringWithFormat:@"%@",[[self.resultArray objectAtIndex:i] objectForKey:@"city"]];
        NSString *zipString = [NSString stringWithFormat:@"%@",[[self.resultArray objectAtIndex:i] objectForKey:@"zipcode"]];
        NSString *addressString = [NSString stringWithFormat:@"%@,%@,%@",locString,cityString,zipString];
        [searchResultArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%@",[[self.resultArray objectAtIndex:i] objectForKey:@"outletName"]],@"searchTypeName",addressString,@"address",[NSString stringWithFormat:@"%@",[[self.resultArray objectAtIndex:i] objectForKey:@"mobileNo"]],@"mobileNo",[NSString stringWithFormat:@"%@",[[self.resultArray objectAtIndex:i] objectForKey:@"phoneNo"]],@"phoneNo", nil]];
       }
    }
    if ([self.searchString isEqualToString:@"Item"])
    {
        headerLabel.text = @"Item Details";
    }
    

    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:136.0/255.0 green:56.0/255.0 blue:55.0/255.0 alpha:1.0];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ozero.png"]];
    [self.navigationItem setHidesBackButton:YES];
   
   
    CGRect frameimg1 = CGRectMake(10,12,20,20);
    menuButton = [[UIButton alloc] initWithFrame:frameimg1];
    [menuButton setBackgroundImage:[UIImage imageNamed:@"Menu.png"] forState:UIControlStateNormal];
    [menuButton setShowsTouchWhenHighlighted:YES];
    UIBarButtonItem *barBtnLeft = [[UIBarButtonItem alloc] initWithCustomView:menuButton];
    self.navigationItem.leftBarButtonItem = barBtnLeft;

 
    CGRect frameimg2 = CGRectMake(screenSize.width-30,8,20,20);
    backButton = [[UIButton alloc] initWithFrame:frameimg2];
    [backButton setBackgroundImage:[UIImage imageNamed:@"Back.png"] forState:UIControlStateNormal];
    [backButton setShowsTouchWhenHighlighted:YES];
    [backButton addTarget:self action:@selector(backButton) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barBtnRight = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.rightBarButtonItem = barBtnRight;
    

}
-(void)backButton
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark UITableView Datasource and Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [searchResultArray count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize constraint = CGSizeMake(tableView.frame.size.width, 20000.0f);
    NSString *venueNameString = [NSString stringWithFormat:@"%@",[[searchResultArray objectAtIndex:indexPath.row] objectForKey:@"searchTypeName"]];
    NSString *addressString = [NSString stringWithFormat:@"%@",[[searchResultArray objectAtIndex:indexPath.row] objectForKey:@"address"]];
    NSString *mobileString = [NSString stringWithFormat:@"%@",[[searchResultArray objectAtIndex:indexPath.row] objectForKey:@"mobileNo"]];
    NSString *phoneString = [NSString stringWithFormat:@"%@",[[searchResultArray objectAtIndex:indexPath.row] objectForKey:@"phoneNo"]];
    
    CGRect venuetextRect = [venueNameString boundingRectWithSize:constraint
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                            attributes:@{NSFontAttributeName:[UIFont fontWithName:@"Roboto" size:15]}
                                               context:nil];
    CGSize venuesize = venuetextRect.size;
    
    CGRect addresstextRect = [addressString boundingRectWithSize:constraint
                                                         options:NSStringDrawingUsesLineFragmentOrigin
                                                      attributes:@{NSFontAttributeName:[UIFont fontWithName:@"Roboto" size:12]}
                                                         context:nil];
    CGSize addresssize = addresstextRect.size;

    CGRect mobiletextRect = [mobileString boundingRectWithSize:constraint
                                                         options:NSStringDrawingUsesLineFragmentOrigin
                                                      attributes:@{NSFontAttributeName:[UIFont fontWithName:@"Roboto" size:12]}
                                                         context:nil];
    CGSize mobilesize = mobiletextRect.size;

    CGRect phonetextRect = [phoneString boundingRectWithSize:constraint
                                                         options:NSStringDrawingUsesLineFragmentOrigin
                                                      attributes:@{NSFontAttributeName:[UIFont fontWithName:@"Roboto" size:12]}
                                                         context:nil];
    CGSize phonesize = phonetextRect.size;
    return venuesize.height+addresssize.height+mobilesize.height+phonesize.height+70;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"ResultCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];

    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
        
    }
    
    backGroundImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height)];
    [backGroundImg setImage:[UIImage imageNamed:@"box.png"]];

    cell.backgroundView = backGroundImg;
   
    CGSize constraint = CGSizeMake(cell.frame.size.width, 20000.0f);
    NSString *venueNameString = [NSString stringWithFormat:@"%@",[[searchResultArray objectAtIndex:indexPath.row] objectForKey:@"searchTypeName"]];
    NSString *addressString = [NSString stringWithFormat:@"%@",[[searchResultArray objectAtIndex:indexPath.row] objectForKey:@"address"]];
    NSString *mobileString = [NSString stringWithFormat:@"%@",[[searchResultArray objectAtIndex:indexPath.row] objectForKey:@"mobileNo"]];
    NSString *phoneString = [NSString stringWithFormat:@"%@",[[searchResultArray objectAtIndex:indexPath.row] objectForKey:@"phoneNo"]];
    
    CGRect venuetextRect = [venueNameString boundingRectWithSize:constraint
                                                         options:NSStringDrawingUsesLineFragmentOrigin
                                                      attributes:@{NSFontAttributeName:[UIFont fontWithName:@"Roboto" size:15]}
                                                         context:nil];
    CGSize venuesize = venuetextRect.size;
    venueLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, cell.frame.size.width, venuesize.height)];
    venueLabel.font = [UIFont fontWithName:@"Roboto" size:15];
    venueLabel.textColor = [UIColor blackColor];
    venueLabel.text = venueNameString;
    venueLabel.numberOfLines = 0;
    [backGroundImg addSubview:venueLabel];
    
    
    CGRect addresstextRect = [addressString boundingRectWithSize:constraint
                                                         options:NSStringDrawingUsesLineFragmentOrigin
                                                      attributes:@{NSFontAttributeName:[UIFont fontWithName:@"Roboto" size:12]}
                                                         context:nil];
    CGSize addresssize = addresstextRect.size;
    
    addressImage = [[UIImageView alloc] initWithFrame:CGRectMake(5,venueLabel.frame.origin.y+venueLabel.frame.size.height+15,20,20)];
    [addressImage setImage:[UIImage imageNamed:@"loc.png"]];
    [backGroundImg addSubview:addressImage];
    
    addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(addressImage.frame.origin.x+addressImage.frame.size.width+5, venueLabel.frame.origin.y+venueLabel.frame.size.height+8, cell.frame.size.width-addressImage.frame.origin.x+addressImage.frame.size.width-5, addresssize.height+20)];
    addressLabel.font = [UIFont fontWithName:@"Roboto" size:13];
    addressLabel.textColor = [UIColor darkGrayColor];
    addressLabel.text = addressString;
    addressLabel.numberOfLines = 0;
    [backGroundImg addSubview:addressLabel];
    
    CGRect mobiletextRect = [mobileString boundingRectWithSize:constraint
                                                       options:NSStringDrawingUsesLineFragmentOrigin
                                                    attributes:@{NSFontAttributeName:[UIFont fontWithName:@"Roboto" size:12]}
                                                       context:nil];
    CGSize mobilesize = mobiletextRect.size;
    mobileImage = [[UIImageView alloc] initWithFrame:CGRectMake(5,addressLabel.frame.origin.y+addressLabel.frame.size.height+5,20,20)];
    [mobileImage setImage:[UIImage imageNamed:@"mob.png"]];
    [backGroundImg addSubview:mobileImage];

    mobileLabel = [[UILabel alloc]initWithFrame:CGRectMake(mobileImage.frame.origin.x+mobileImage.frame.size.width+5, addressLabel.frame.origin.y+addressLabel.frame.size.height+8, cell.frame.size.width-mobileImage.frame.origin.x+mobileImage.frame.size.width-5, mobilesize.height)];
    mobileLabel.font = [UIFont fontWithName:@"Roboto" size:13];
    mobileLabel.text = mobileString;
    mobileLabel.textColor = [UIColor darkGrayColor];
    mobileLabel.numberOfLines = 0;
    [backGroundImg addSubview:mobileLabel];
    
    CGRect phonetextRect = [phoneString boundingRectWithSize:constraint
                                                     options:NSStringDrawingUsesLineFragmentOrigin
                                                  attributes:@{NSFontAttributeName:[UIFont fontWithName:@"Roboto" size:12]}
                                                     context:nil];
    CGSize phonesize = phonetextRect.size;
    
    phoneImage = [[UIImageView alloc] initWithFrame:CGRectMake(5,mobileLabel.frame.origin.y+mobileLabel.frame.size.height+5,20,20)];
    [phoneImage setImage:[UIImage imageNamed:@"cal.png"]];
    [backGroundImg addSubview:phoneImage];
    
    phoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(phoneImage.frame.origin.x+phoneImage.frame.size.width+5, mobileLabel.frame.origin.y+mobileLabel.frame.size.height+8, cell.frame.size.width-phoneImage.frame.origin.x+phoneImage.frame.size.width-5, phonesize.height)];
    phoneLabel.font = [UIFont fontWithName:@"Roboto" size:13];
    phoneLabel.text = phoneString;
    phoneLabel.textColor = [UIColor darkGrayColor];
    phoneLabel.numberOfLines = 0;
    [backGroundImg addSubview:phoneLabel];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
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
