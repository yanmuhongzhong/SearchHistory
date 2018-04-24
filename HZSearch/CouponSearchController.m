//
//  CouponSearchController.m
//  baobaotong
//
//  Created by Pig.Zhong on 2018/4/11.
//  Copyright © 2018年 zzy. All rights reserved.
//

#import "CouponSearchController.h"
#import "UIView+BBLayout.h"

// 屏幕宽高
#define kDeviceWidth [UIScreen mainScreen].bounds.size.width
#define KDeviceHeight [UIScreen mainScreen].bounds.size.height
// kNavHeight
#define kStatusBarHeight (KDeviceHeight == 812 ? 44.0 : 20.0)
#define kNavHeight (kStatusBarHeight + 44.0)
// 字体
#define kFont(fontSize) [UIFont systemFontOfSize:fontSize]
#define kBoldFont(fontSize) [UIFont boldSystemFontOfSize:fontSize]
// 十六进制颜色值
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define UIColorFromRGBA(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]

@interface CouponSearchController ()<UITextFieldDelegate>
{
    UIView *remenView;
}
@property (nonatomic, strong) NSArray *originArr;
@property (nonatomic, strong) NSMutableArray *searchTextArr;
@property (nonatomic, weak) UITextField *searchTextField;

@property (nonatomic, strong) UIBarButtonItem *closeItem;
@property (nonatomic, strong) UIBarButtonItem *backItem;

// 搜索历史文字描述
@property (nonatomic, strong) UILabel *searchHistoryLab;
// 清空历史记录
@property (nonatomic, strong) UIButton *clearBtn;
// 搜索按钮
@property (nonatomic, strong) UIButton *searchBtn;
// searchView
@property (nonatomic, strong) UIImageView *searchView;

@end

@implementation CouponSearchController

- (UILabel *)searchHistoryLab {
    
    if (_searchHistoryLab == nil) {
        _searchHistoryLab = [[UILabel alloc]initWithFrame:CGRectMake(12, 17, 80, 20)];
        _searchHistoryLab.text = @"历史搜索";
        _searchHistoryLab.textColor = [UIColor grayColor];
        _searchHistoryLab.font = [UIFont systemFontOfSize:13];
    }
    return _searchHistoryLab;
}

-(UIButton *)clearBtn {
    
    if (_clearBtn == nil) {
        _clearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _clearBtn.frame = CGRectMake(kDeviceWidth - 12 - 80, 17, 80, 20);
        [_clearBtn setImage:[UIImage imageNamed:@"icon_ic_tool_delete_disable"] forState:UIControlStateNormal];
        [_clearBtn sizeToFit];
        _clearBtn.bb_right = kDeviceWidth - 16;
        [_clearBtn addTarget:self action:@selector(clear:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _clearBtn;
}

- (UIButton *)searchBtn {
    
    if (_searchBtn == nil) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"搜索" forState:UIControlStateNormal];
        btn.titleLabel.font = kFont(16);
        [btn setTitleColor:UIColorFromRGB(0xB3B3B3) forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(rightmengbutClick) forControlEvents:UIControlEventTouchUpInside];
        [btn sizeToFit];
        _searchBtn = btn;
    }
    return _searchBtn;
}

- (UIImageView *)searchView {
    
    if (_searchView == nil) {
        
        UIImageView *bgimg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth - 60 * 2, 28)];
        bgimg.backgroundColor = UIColorFromRGB(0xEBEBEB);
        bgimg.layer.cornerRadius = 2;
        [bgimg.layer setMasksToBounds:YES];
        bgimg.userInteractionEnabled = YES;
        
        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(8, 6, 16, 16)];
        img.image = [UIImage imageNamed:@"icon_general_ic_search_small"];
        [bgimg addSubview:img];
        
        
        
        UITextField *text = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(img.frame)+4, 1, bgimg.frame.size.width-40, 26)];
        text.placeholder = @"请输入商家/商品/地址";
        text.textColor = [UIColor blackColor];
        text.font = [UIFont systemFontOfSize:12];
        text.delegate = self;
        text.returnKeyType = UIReturnKeySearch;
        [bgimg addSubview:text];
        self.searchTextField = text;
        
        _searchView = bgimg;
    }
    return _searchView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColorFromRGB(0xF2F2F2);
    
    [self setNavBar];
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textfiledChange:) name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    [_searchTextField becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    [_searchTextField resignFirstResponder];
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)setNavBar{
    
    UIButton *lbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [lbtn setImage:[UIImage imageNamed:@"ic_back_main"] forState:UIControlStateNormal];
    [lbtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [lbtn sizeToFit];
//    lbtn.backgroundColor = [UIColor greenColor];
//    lbtn.frame = CGRectMake(0, 0, 44, 44);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:lbtn];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.searchBtn];
    
    UIImageView *bgimg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth - 60 * 2, 28)];
    bgimg.backgroundColor = UIColorFromRGB(0xEBEBEB);
    bgimg.layer.cornerRadius = 2;
    [bgimg.layer setMasksToBounds:YES];
    bgimg.userInteractionEnabled = YES;
    self.navigationItem.titleView = bgimg;
    
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(8, (bgimg.bb_height - 16) * 0.5 - 1, 16, 16)];
    img.image = [UIImage imageNamed:@"icon_general_ic_search_small"];
    [bgimg addSubview:img];
    
    
    
    UITextField *text = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(img.frame)+4, 0, bgimg.frame.size.width-40, 28)];
    text.placeholder = @"请输入关键字...";
    text.textColor = [UIColor blackColor];
    text.font = [UIFont systemFontOfSize:12];
    text.delegate = self;
    text.returnKeyType = UIReturnKeySearch;
    [bgimg addSubview:text];
    self.searchTextField = text;
}

-(void)setupUI
{
    
    remenView = [[UIView alloc]initWithFrame:CGRectMake(0, kNavHeight, kDeviceWidth, KDeviceHeight - kNavHeight)];
    remenView.userInteractionEnabled = YES;
    [self.view addSubview:remenView];
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取数组NSArray类型的数据
    NSArray *myArray = [[NSArray alloc] initWithArray:[userDefaultes arrayForKey:@"myArray"]];
    // NSArray --> NSMutableArray
    _searchTextArr = [NSMutableArray array];
    _searchTextArr = [myArray mutableCopy];
    if (_searchTextArr.count > 0) {
        [self searchHistory:_searchTextArr];
    }
}

- (void)searchHistory: (NSMutableArray *)mArr {
    
    remenView.backgroundColor = [UIColor whiteColor];
    [remenView addSubview:self.searchHistoryLab];
    [remenView addSubview:self.clearBtn];
    
    UIView *separateView = [[UIView alloc] initWithFrame:CGRectMake(24, self.searchHistoryLab.bb_bottom + 11, kDeviceWidth - 24, 0.5)];
    separateView.backgroundColor = UIColorFromRGB(0xE5E5E5);
    [remenView addSubview:separateView];
    
    float butX = 16;
    float butY = separateView.bb_bottom + 12;
    for(int i = 0; i < mArr.count; i++)
    {
        NSDictionary *fontDict = @{NSFontAttributeName:[UIFont systemFontOfSize:12]};
        // 限制10字数 的宽度
        NSString *maxSizeStr = @"一一一一一一一一一一一";
        CGSize maxSizeStrSize = [maxSizeStr boundingRectWithSize:CGSizeMake(MAXFLOAT, 28) options:NSStringDrawingUsesLineFragmentOrigin attributes:fontDict context:nil].size;
        // 宽度自适应
        CGSize labSize = [mArr[i] boundingRectWithSize:CGSizeMake(MAXFLOAT, 28) options:NSStringDrawingUsesLineFragmentOrigin attributes:fontDict context:nil].size;
        
        CGFloat butWidth = 0;
        if (labSize.width > maxSizeStrSize.width) { // 如果文字的宽度大于最大宽度, 使用最大宽度作为文字宽度
            butWidth = maxSizeStrSize.width;
        } else {
            butWidth = labSize.width;
        }
        
        if (butX + butWidth > kDeviceWidth-16) { // 换行
            
            butX = 16;
            butY += labSize.height * 2 + 9;
        }
        
        UIButton *but = [[UIButton alloc]initWithFrame:CGRectMake(butX, butY, butWidth + 9, 28)];
        if (butWidth + 16>kDeviceWidth - 16 * 2) {
            but.frame = CGRectMake(butX, butY, kDeviceWidth-16*2, 28);
        }
        [but setTitle:mArr[i] forState:UIControlStateNormal];
        [but setTitleColor:UIColorFromRGB(0x666666) forState:UIControlStateNormal];
        but.titleLabel.font = [UIFont systemFontOfSize:12];
        but.layer.cornerRadius = 4;
        but.layer.borderColor = UIColorFromRGB(0xB3B3B3).CGColor;
        but.layer.borderWidth = 1;
        //        but.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;// 文字左对齐 无效
        but.tag = i;
        [but addTarget:self action:@selector(searchHistoryBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        but.titleLabel.lineBreakMode =  NSLineBreakByTruncatingTail; // 省略号放右边
        [remenView addSubview:but];
        
        butX = CGRectGetMaxX(but.frame)+8;
        
        if (i == mArr.count - 1) {
            
            remenView.bb_height = but.bb_bottom + 12;
        }
    }
}

// return按钮操作
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self.view endEditing:YES];
    
    if ([self.searchTextField.text isEqualToString:@""]) { //如果没有输入任何文字, 不做操作
        
    }else{
        
        NSLog(@"return搜");
        [self searchText:self.searchTextField.text];
    }
    
    return YES;
}

-(void)textfiledChange:(NSNotification *)obj{
    
    [self changeSet];
}

-(void)changeSet
{
    if (_searchTextField.text.length > 0) {
        [self.searchBtn setTitleColor:UIColorFromRGB(0xFF9600) forState:UIControlStateNormal];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.searchBtn];
    }else
    {
        [self.searchBtn setTitleColor:UIColorFromRGB(0xB3B3B3) forState:UIControlStateNormal];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.searchBtn];
    }
}

- (void)backClick {
    
    [self dismissViewControllerAnimated:self completion:nil];
}

- (void)rightmengbutClick {
    
    UIBarButtonItem *item = self.navigationItem.rightBarButtonItem;
    UIButton *button = (UIButton *)item.customView;
    NSString *rightItemStr = button.titleLabel.text;
    NSLog(@"%@", rightItemStr);
    [self searchText:self.searchTextField.text];
    
}

/// 搜索历史按钮点击
- (void)searchHistoryBtnClick:(UIButton *)button {
    
    NSLog(@"%ld",button.tag);
    [self searchText:button.titleLabel.text];
    self.searchTextField.text = button.titleLabel.text;
}

/// 搜索历史
-(void)searchText: (NSString *)seaTxt
{
    [_searchTextField resignFirstResponder];
    // 搜索服务器请求
    [ self getData: seaTxt];
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    // 去除字符串两边的空格
    NSString *removeBlackStr = [seaTxt stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    //读取数组NSArray类型的数据
    NSArray *myArray = [[NSArray alloc] initWithArray:[userDefaultes arrayForKey:@"myArray"]];
    _searchTextArr = [myArray mutableCopy];
    
    BOOL isEqualTo1,isEqualTo2;
    isEqualTo1 = NO;
    isEqualTo2 = NO;
    
    if (_searchTextArr.count > 0) {
        isEqualTo2 = YES;
        //判断搜索内容是否存在，存在的话放到数组第一位，不存在的话添加。
        for (NSString * str in myArray) {
            if ([removeBlackStr isEqualToString:str]) {
                //获取指定对象的索引
                NSUInteger index = [myArray indexOfObject:removeBlackStr];
                [_searchTextArr removeObjectAtIndex:index];
                if (removeBlackStr != nil && ![removeBlackStr isEqualToString:@""]) {
                    [_searchTextArr insertObject:removeBlackStr atIndex:0];
                }
                isEqualTo1 = YES;
                break;
            }
        }
    }
    
    if (!isEqualTo1 || !isEqualTo2) {
        if (removeBlackStr != nil && ![removeBlackStr isEqualToString:@""]) {
            [_searchTextArr insertObject:removeBlackStr atIndex:0];
        }
    }
    
    if(_searchTextArr.count > 10)
    {
        [_searchTextArr removeObjectAtIndex:_searchTextArr.count - 1];
    }
    //将上述数据全部存储到NSUserDefaults中
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:_searchTextArr forKey:@"myArray"];
    [[remenView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    remenView.backgroundColor = UIColorFromRGB(0xF2F2F2);
    [self searchHistory:_searchTextArr];
}

/// 清空
- (void)clear: (UIButton *)button {
    
    [_searchTextArr removeAllObjects];
    //将数据全部从NSUserDefaults中移除
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:nil forKey:@"myArray"];
    [[remenView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    remenView.backgroundColor = UIColorFromRGB(0xF2F2F2);
}

#pragma mark ----- getData 和服务器交互
- (void)getData: (NSString *)seaTxt {
    NSLog(@"getData 和服务器交互");
}

@end
