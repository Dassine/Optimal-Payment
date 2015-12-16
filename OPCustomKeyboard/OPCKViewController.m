//
//  OPCKViewController.m
//  OPCustomKeyboard
//
//  Created by Lilia Dassine BELAID on 13-06-12.
//  Copyright (c) 2013 Lilia Dassine BELAID. All rights reserved.
//

#import "OPCKViewController.h"


#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
#define IS_IPOD   ( [ [ [ UIDevice currentDevice ] model ] isEqualToString: @"iPod touch" ] ) || defined(IS_IPOD)

@interface OPCKViewController ()

@property (nonatomic, strong) UIView *screenView;
@property (nonatomic, strong) UILabel *tipTitleLabel;
@property (nonatomic, strong) UILabel *tipLabel;
@property (nonatomic, strong) UILabel *totalBeforeTipTitleLabel;
@property (nonatomic, strong) UILabel *totalBeforeTipLabel;
@property (nonatomic, strong) UILabel *totalAfterTipTitleLabel;
@property (nonatomic, strong) UILabel *totalAfterTipLabel;
@property (nonatomic, strong) UIView *keyButtonsView;
@property (nonatomic, strong) NSMutableArray *keyButtonsArray;


@property (nonatomic) NSString *tip;
@property (nonatomic) NSString *totalBeforeTip;
@property (nonatomic) NSString *totalAfterTip;

@property (nonatomic) BOOL poucentageAction;

@end

@implementation OPCKViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _tip = @"0.00";
        _totalBeforeTip = @"15.99";
        _totalAfterTip = @"15.99";
        _poucentageAction = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    _screenView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, (IS_IPHONE_5) ? 225 : 160)];
    [_screenView setBackgroundColor:[UIColor lightGrayColor]];
    [self.view addSubview:_screenView];
    
    [self configureDisplayedLabelsUI];
    
    _keyButtonsView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_screenView.frame), 320, CGRectGetHeight(self.view.frame)-CGRectGetMaxY(_screenView.frame))];
    [_keyButtonsView setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:_keyButtonsView];
    
    [self configureKeysUI];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configureDisplayedLabelsUI {
    _tipTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, (IS_IPHONE_5) ? 10 : 10, 310, 20)];
    [_tipTitleLabel setFont:[UIFont boldSystemFontOfSize:15]];
    [_tipTitleLabel setTextAlignment:NSTextAlignmentLeft];
    [_tipTitleLabel setBackgroundColor:[UIColor clearColor]];
    [_tipTitleLabel setTextColor:[UIColor grayColor]];
    [_tipTitleLabel setText:@"Tip"];
    [self.screenView addSubview:_tipTitleLabel];
    
    _tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, (IS_IPHONE_5) ? 30 :30, 310, (IS_IPHONE_5) ? 100:70)];
    [_tipLabel setFont:[UIFont boldSystemFontOfSize:(IS_IPHONE_5) ? 95 : 65]];
    [_tipLabel setAdjustsFontSizeToFitWidth:YES];
    [_tipLabel setTextAlignment:NSTextAlignmentLeft];
    [_tipLabel setBackgroundColor:[UIColor clearColor]];
    [_tipLabel setText:@"$0.00"];
    [self.screenView addSubview:_tipLabel];
    
    
    _totalBeforeTipTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, (IS_IPHONE_5) ? 150 : 100 , 200, 20)];
    [_totalBeforeTipTitleLabel setFont:[UIFont boldSystemFontOfSize:15]];
    [_totalBeforeTipTitleLabel setTextAlignment:NSTextAlignmentLeft];
    [_totalBeforeTipTitleLabel setBackgroundColor:[UIColor clearColor]];
    [_totalBeforeTipTitleLabel setTextColor:[UIColor grayColor]];
    [_totalBeforeTipTitleLabel setText:@"Before tip"];
    [self.screenView addSubview:_totalBeforeTipTitleLabel];
    
    _totalBeforeTipLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, (IS_IPHONE_5) ? 170 : 112, 200, 50)];
    [_totalBeforeTipLabel setFont:[UIFont boldSystemFontOfSize:45]];
    [_totalBeforeTipLabel setTextAlignment:NSTextAlignmentLeft];
    [_totalBeforeTipLabel setTextColor:[UIColor greenColor]];
    [_totalBeforeTipLabel setBackgroundColor:[UIColor clearColor]];
    [_totalBeforeTipLabel setText:[NSString stringWithFormat:@"$%@", _totalBeforeTip]];
    [self.screenView addSubview:_totalBeforeTipLabel];
    
    
    
    _totalBeforeTipTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake((IS_IPHONE_5) ? 165 : 150, (IS_IPHONE_5) ? 150 : 100, 200, 20)];
    [_totalBeforeTipTitleLabel setFont:[UIFont boldSystemFontOfSize:15]];
    [_totalBeforeTipTitleLabel setTextAlignment:NSTextAlignmentLeft];
    [_totalBeforeTipTitleLabel setBackgroundColor:[UIColor clearColor]];
    [_totalBeforeTipTitleLabel setTextColor:[UIColor grayColor]];
    [_totalBeforeTipTitleLabel setText:@"After tip"];
    [self.screenView addSubview:_totalBeforeTipTitleLabel];
    
    _totalAfterTipLabel = [[UILabel alloc] initWithFrame:CGRectMake((IS_IPHONE_5) ? 165 : 150, (IS_IPHONE_5) ? 170 : 112, 150, 50)];
    [_totalAfterTipLabel setFont:[UIFont boldSystemFontOfSize:45]];
    [_totalAfterTipLabel setAdjustsFontSizeToFitWidth:YES];
    [_totalAfterTipLabel setTextAlignment:NSTextAlignmentLeft];
    [_totalAfterTipLabel setTextColor:[UIColor redColor]];
    [_totalAfterTipLabel setBackgroundColor:[UIColor clearColor]];
    [_totalAfterTipLabel setText:[NSString stringWithFormat:@"$%@", _totalAfterTip]];
    [self.screenView addSubview:_totalAfterTipLabel];
    
}

- (void)configureKeysUI {
    NSInteger i = 0, x = 0,y = 0, maxX, maxY;
    
    _keyButtonsArray = [[NSMutableArray alloc] init];
    
    for (NSString *keyName in kChar) {
        UIButton *keyButton = [[UIButton alloc] initWithFrame:(![keyName isEqualToString:@">"]) ? CGRectMake(x*106, y*50, 106, 50) : CGRectMake(2*106, 4*50, 106, 2*50)];
        [keyButton setTitle:keyName forState:UIControlStateNormal];
        [keyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [keyButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [keyButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        keyButton.tag = i++;
        [_keyButtonsArray addObject:keyButton];
        [self.keyButtonsView addSubview:keyButton];
        
        maxX = (y < 4) ? 2 : 1;
        maxY = (y < 4) ? 4 : 6;
        if (x == maxX && y < maxY) {
            x=0;
            UIImageView * separator = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"SeparatorLine"]]];
            [separator setFrame:(y < 5) ? CGRectMake(10, CGRectGetMaxY(keyButton.frame), (y < 4) ? 300 : 194, 2) : CGRectZero];
            [self.keyButtonsView addSubview:separator];
            
            y++;
            
            
        } else
            x++;
    }
    
    
}

-(void)buttonPressed:(UIButton *)sender {
    if (sender.tag > 2  && _poucentageAction) {
        _tip= [NSString stringWithFormat:@"0.00"];
        [_tipLabel setText:[NSString stringWithFormat:@"$%@", _tip]];
        _totalAfterTip = _totalBeforeTip;
        [_totalAfterTipLabel setText:[NSString stringWithFormat:@"$%@", _totalAfterTip]];
        _poucentageAction= NO;
        
    }
    
    switch (sender.tag) {
        case 0:
        case 1:
        case 2:
        {
            _tip = [NSString stringWithFormat:@"%.2f", [_totalBeforeTip doubleValue]*[[kChar objectAtIndex:sender.tag] intValue]/100];
            [_tipLabel setText:[NSString stringWithFormat:@"$%@", _tip]];
            
            _totalAfterTip = [NSString stringWithFormat:@"%.2f", [_totalBeforeTip doubleValue]+[_totalBeforeTip doubleValue]*[[kChar objectAtIndex:sender.tag] intValue]/100];
            [_totalAfterTipLabel setText:[NSString stringWithFormat:@"$%@", _totalAfterTip]];
            _poucentageAction = YES;
        }
            break;
        case 3:
        case 4:
        case 5:
        case 6:
        case 7:
        case 8:
        case 9:
        case 10:
        case 11:
        case 12:
        case 13:
        {
            if ([_tip rangeOfString:@"."].location != NSNotFound && [_tip length] <= 8){
                if (sender.tag == 12)
                    _tip = [NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%.2f",[_tip doubleValue] *100]];
                else if ([_tipLabel.text rangeOfString:@".00"].location != NSNotFound)
                    _tip = [_tip  stringByReplacingOccurrencesOfString:[_tip substringFromIndex:[_tip rangeOfString:@"."].location]
                                                            withString:[NSString stringWithFormat:@".0%@",[kChar objectAtIndex:sender.tag]]];
                else  if ([_tip rangeOfString:@".0"].location != NSNotFound)
                    _tip = [_tip  stringByReplacingOccurrencesOfString:[_tip substringFromIndex:[_tip rangeOfString:@"."].location]
                                                            withString:[NSString stringWithFormat:@".%@%@",[_tip substringFromIndex:[_tip rangeOfString:@".0"].location+2], [kChar objectAtIndex:sender.tag]]];
                else 
                    _tip = [NSString stringWithFormat:@"%@%@",[NSString stringWithFormat:@"%.1f",[_tip doubleValue] *10], [kChar objectAtIndex:sender.tag]];
                
                
            }
            
            [_tipLabel setText:[NSString stringWithFormat:@"$%@", _tip]];
            
            _totalAfterTip = [NSString stringWithFormat:@"%.2f", [_totalBeforeTip doubleValue]+[_tip doubleValue]];
            [_totalAfterTipLabel setText:[NSString stringWithFormat:@"$%@", _totalAfterTip]];
            
        }
            break;
            
        case 15:
            _tip= [NSString stringWithFormat:@"0.00"];
            [_tipLabel setText:[NSString stringWithFormat:@"$%@", _tip]];
            _totalAfterTip = _totalBeforeTip;
            [_totalAfterTipLabel setText:[NSString stringWithFormat:@"$%@", _totalAfterTip]];
            break;
        case 14:
            [[[UIAlertView alloc] initWithTitle:@"Leaving this view" message:@"GO BACK HOME" delegate:nil cancelButtonTitle:@"ON" otherButtonTitles:nil] show];
            break;
            
        case 16:
            [[[UIAlertView alloc] initWithTitle:@"Leaving this view" message:@"GO TO ANIMATION" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
            break;
        default:
            break;
    }
}

@end
