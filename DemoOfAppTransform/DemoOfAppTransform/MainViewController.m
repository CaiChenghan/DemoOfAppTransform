//
//  MainViewController.m
//  DemoOfAppTransform
//
//  Created by 蔡成汉 on 2017/3/29.
//  Copyright © 2017年 上海泰侠网络科技有限公司. All rights reserved.
//

#import "MainViewController.h"
#import "LocationViewController.h"
#import <Masonry/Masonry.h>

@interface MainViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic , strong) UITableView *myTableView;
@property (nonatomic , strong) NSMutableArray *dataArray;

@end

@implementation MainViewController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _dataArray = [NSMutableArray array];
        [_dataArray addObject:[self createArrayOne]];
        [_dataArray addObject:[self createArrayTwo]];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"APP跳转";
    self.view.backgroundColor = [UIColor whiteColor];
    
    _myTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _myTableView.dataSource = self;
    _myTableView.delegate = self;
    _myTableView.tableFooterView = [UIView new];
    [self.view addSubview:_myTableView];
}

#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *tpArray = [_dataArray objectAtIndex:section];
    return tpArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    }
    NSArray *tpArray = [_dataArray objectAtIndex:indexPath.section];
    NSDictionary *tpDic = [tpArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [tpDic objectForKey:@"name"];
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UITableViewHeaderFooterView *tpView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"UITableViewHeaderFooterView"];
    if (tpView == nil) {
        tpView = [[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:@"UITableViewHeaderFooterView"];
    }
    return tpView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44.0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20.0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.section == 0) {
        //普通跳转
        NSArray *tpArray = [_dataArray objectAtIndex:indexPath.section];
        NSDictionary *tpDic = [tpArray objectAtIndex:indexPath.row];
        NSURL *url = [NSURL URLWithString:[tpDic objectForKey:@"url"]];
        if ([[UIApplication sharedApplication]canOpenURL:url]) {
            [[UIApplication sharedApplication]openURL:url options:@{} completionHandler:^(BOOL success) {
                if (success) {
                    NSLog(@"打开成功");
                }else{
                    NSLog(@"打开失败");
                }
            }];
        }
    }else{
        //进入权限页面
        LocationViewController *viewController = [[LocationViewController alloc]init];
        [self.navigationController pushViewController:viewController animated:YES];
    }
}

#pragma mark - createArray

-(NSArray *)createArrayOne{
    NSMutableArray *array = [NSMutableArray array];
    
    NSMutableDictionary *tpDic1 = [NSMutableDictionary dictionary];
    [tpDic1 setValue:@"WiFi设置" forKey:@"name"];
    [tpDic1 setValue:@"App-Prefs:root=WIFI" forKey:@"url"];
    [array addObject:tpDic1];
    
    NSMutableDictionary *tpDic2 = [NSMutableDictionary dictionary];
    [tpDic2 setValue:@"蓝牙设置" forKey:@"name"];
    [tpDic2 setValue:@"App-Prefs:root=Bluetooth" forKey:@"url"];
    [array addObject:tpDic2];
    
    NSMutableDictionary *tpDic3 = [NSMutableDictionary dictionary];
    [tpDic3 setValue:@"蜂窝数据" forKey:@"name"];
    [tpDic3 setValue:@"App-Prefs:root=MOBILE_DATA_SETTINGS_ID" forKey:@"url"];
    [array addObject:tpDic3];
    
    NSMutableDictionary *tpDic4 = [NSMutableDictionary dictionary];
    [tpDic4 setValue:@"个人热点" forKey:@"name"];
    [tpDic4 setValue:@"App-Prefs:root=INTERNET_TETHERING" forKey:@"url"];
    [array addObject:tpDic4];
    
    NSMutableDictionary *tpDic5 = [NSMutableDictionary dictionary];
    [tpDic5 setValue:@"通知" forKey:@"name"];
    [tpDic5 setValue:@"App-Prefs:root=NOTIFICATIONS_ID" forKey:@"url"];
    [array addObject:tpDic5];
    
    NSMutableDictionary *tpDic6 = [NSMutableDictionary dictionary];
    [tpDic6 setValue:@"通用" forKey:@"name"];
    [tpDic6 setValue:@"App-Prefs:root=General" forKey:@"url"];
    [array addObject:tpDic6];
    
    NSMutableDictionary *tpDic7 = [NSMutableDictionary dictionary];
    [tpDic7 setValue:@"显示与亮度" forKey:@"name"];
    [tpDic7 setValue:@"App-Prefs:root=DISPLAY" forKey:@"url"];
    [array addObject:tpDic7];
    
    NSMutableDictionary *tpDic8 = [NSMutableDictionary dictionary];
    [tpDic8 setValue:@"壁纸" forKey:@"name"];
    [tpDic8 setValue:@"App-Prefs:root=Wallpaper" forKey:@"url"];
    [array addObject:tpDic8];
    
    NSMutableDictionary *tpDic9 = [NSMutableDictionary dictionary];
    [tpDic9 setValue:@"声音" forKey:@"name"];
    [tpDic9 setValue:@"App-Prefs:root=Sounds" forKey:@"url"];
    [array addObject:tpDic9];
    
    NSMutableDictionary *tpDic10 = [NSMutableDictionary dictionary];
    [tpDic10 setValue:@"电池电量" forKey:@"name"];
    [tpDic10 setValue:@"App-Prefs:root=BATTERY_USAGE" forKey:@"url"];
    [array addObject:tpDic10];
    
    NSMutableDictionary *tpDic11 = [NSMutableDictionary dictionary];
    [tpDic11 setValue:@"隐私" forKey:@"name"];
    [tpDic11 setValue:@"App-Prefs:root=Privacy" forKey:@"url"];
    [array addObject:tpDic11];
    
    NSMutableDictionary *tpDic12 = [NSMutableDictionary dictionary];
    [tpDic12 setValue:@"iCloud" forKey:@"name"];
    [tpDic12 setValue:@"App-Prefs:root=CASTLE" forKey:@"url"];
    [array addObject:tpDic12];
    
    NSMutableDictionary *tpDic13 = [NSMutableDictionary dictionary];
    [tpDic13 setValue:@"iCloud备份" forKey:@"name"];
    [tpDic13 setValue:@"App-Prefs:root=CASTLE&path=BACKUP" forKey:@"url"];
    [array addObject:tpDic13];
    
    NSMutableDictionary *tpDic14 = [NSMutableDictionary dictionary];
    [tpDic14 setValue:@"iTunesStore与AppStore" forKey:@"name"];
    [tpDic14 setValue:@"App-Prefs:root=STORE" forKey:@"url"];
    [array addObject:tpDic14];
    
    NSMutableDictionary *tpDic15 = [NSMutableDictionary dictionary];
    [tpDic15 setValue:@"存储空间" forKey:@"name"];
    [tpDic15 setValue:@"App-Prefs:root=General&path=STORAGE_ICLOUD_USAGE/DEVICE_STORAGE" forKey:@"url"];
    [array addObject:tpDic15];
    
    NSMutableDictionary *tpDic16 = [NSMutableDictionary dictionary];
    [tpDic16 setValue:@"VPN" forKey:@"name"];
    [tpDic16 setValue:@"App-Prefs:root=General&path=VPN" forKey:@"url"];
    [array addObject:tpDic16];
    
    NSMutableDictionary *tpDic17 = [NSMutableDictionary dictionary];
    [tpDic17 setValue:@"定位设置" forKey:@"name"];
    [tpDic17 setValue:@"App-Prefs:root=Privacy&path=LOCATION" forKey:@"url"];
    [array addObject:tpDic17];
    
    NSMutableDictionary *tpDic18 = [NSMutableDictionary dictionary];
    [tpDic18 setValue:@"软件更新" forKey:@"name"];
    [tpDic18 setValue:@"App-Prefs:root=General&path=SOFTWARE_UPDATE_LINK" forKey:@"url"];
    [array addObject:tpDic18];
    
    NSMutableDictionary *tpDic19 = [NSMutableDictionary dictionary];
    [tpDic19 setValue:@"关于本机" forKey:@"name"];
    [tpDic19 setValue:@"App-Prefs:root=General&path=About" forKey:@"url"];
    [array addObject:tpDic19];
    
    NSMutableDictionary *tpDic20 = [NSMutableDictionary dictionary];
    [tpDic20 setValue:@"辅助功能" forKey:@"name"];
    [tpDic20 setValue:@"App-Prefs:root=General&path=ACCESSIBILITY" forKey:@"url"];
    [array addObject:tpDic20];
    
    NSMutableDictionary *tpDic21 = [NSMutableDictionary dictionary];
    [tpDic21 setValue:@"键盘设置" forKey:@"name"];
    [tpDic21 setValue:@"App-Prefs:root=General&path=Keyboard" forKey:@"url"];
    [array addObject:tpDic21];
    
    NSMutableDictionary *tpDic22 = [NSMutableDictionary dictionary];
    [tpDic22 setValue:@"日期与时间" forKey:@"name"];
    [tpDic22 setValue:@"App-Prefs:root=General&path=DATE_AND_TIME" forKey:@"url"];
    [array addObject:tpDic22];
    
    NSMutableDictionary *tpDic23 = [NSMutableDictionary dictionary];
    [tpDic23 setValue:@"语言" forKey:@"name"];
    [tpDic23 setValue:@"App-Prefs:root=General&path=INTERNATIONAL" forKey:@"url"];
    [array addObject:tpDic23];
    
    NSMutableDictionary *tpDic24 = [NSMutableDictionary dictionary];
    [tpDic24 setValue:@"描述文件" forKey:@"name"];
    [tpDic24 setValue:@"App-Prefs:root=General&path=ManagedConfigurationList" forKey:@"url"];
    [array addObject:tpDic24];
    
    NSMutableDictionary *tpDic25 = [NSMutableDictionary dictionary];
    [tpDic25 setValue:@"还原" forKey:@"name"];
    [tpDic25 setValue:@"App-Prefs:root=General&path=Reset" forKey:@"url"];
    [array addObject:tpDic25];
    
    NSMutableDictionary *tpDic26 = [NSMutableDictionary dictionary];
    [tpDic26 setValue:@"CarPlay" forKey:@"name"];
    [tpDic26 setValue:@"App-Prefs:root=General&path=CARPLAY" forKey:@"url"];
    [array addObject:tpDic26];
    
    NSMutableDictionary *tpDic27 = [NSMutableDictionary dictionary];
    [tpDic27 setValue:@"FaceTime" forKey:@"name"];
    [tpDic27 setValue:@"App-Prefs:root=FACETIME" forKey:@"url"];
    [array addObject:tpDic27];
    
    NSMutableDictionary *tpDic28 = [NSMutableDictionary dictionary];
    [tpDic28 setValue:@"音乐" forKey:@"name"];
    [tpDic28 setValue:@"App-Prefs:root=MUSIC" forKey:@"url"];
    [array addObject:tpDic28];
    
    NSMutableDictionary *tpDic29 = [NSMutableDictionary dictionary];
    [tpDic29 setValue:@"照片与相机" forKey:@"name"];
    [tpDic29 setValue:@"App-Prefs:root=Photos" forKey:@"url"];
    [array addObject:tpDic29];
    
    NSMutableDictionary *tpDic30 = [NSMutableDictionary dictionary];
    [tpDic30 setValue:@"电话设置" forKey:@"name"];
    [tpDic30 setValue:@"App-Prefs:root=Phone" forKey:@"url"];
    [array addObject:tpDic30];
    
    NSMutableDictionary *tpDic31 = [NSMutableDictionary dictionary];
    [tpDic31 setValue:@"Notes" forKey:@"name"];
    [tpDic31 setValue:@"App-Prefs:root=NOTES" forKey:@"url"];
    [array addObject:tpDic31];
    
    NSMutableDictionary *tpDic32 = [NSMutableDictionary dictionary];
    [tpDic32 setValue:@"Twitter" forKey:@"name"];
    [tpDic32 setValue:@"App-Prefs:root=TWITTER" forKey:@"url"];
    [array addObject:tpDic32];
    
    NSMutableDictionary *tpDic33 = [NSMutableDictionary dictionary];
    [tpDic33 setValue:@"拨打电话" forKey:@"name"];
    [tpDic33 setValue:@"tel://10010" forKey:@"url"];
    [array addObject:tpDic33];
    
    NSMutableDictionary *tpDic34 = [NSMutableDictionary dictionary];
    [tpDic34 setValue:@"发送短信" forKey:@"name"];
    [tpDic34 setValue:@"sms://10010" forKey:@"url"];
    [array addObject:tpDic34];
    
    NSMutableDictionary *tpDic35 = [NSMutableDictionary dictionary];
    [tpDic35 setValue:@"发送邮件" forKey:@"name"];
    [tpDic35 setValue:@"mailto://1178752402@qq.com" forKey:@"url"];
    [array addObject:tpDic35];
    
    NSMutableDictionary *tpDic36 = [NSMutableDictionary dictionary];
    [tpDic36 setValue:@"打开网址" forKey:@"name"];
    [tpDic36 setValue:@"https://www.caichenghan.com" forKey:@"url"];
    [array addObject:tpDic36];
    
    return array;
}

-(NSArray *)createArrayTwo{
    NSMutableArray *array = [NSMutableArray array];
    
    NSMutableDictionary *tpDic = [NSMutableDictionary dictionary];
    [tpDic setValue:@"跳转自己的权限设置页" forKey:@"name"];
    [tpDic setValue:@"" forKey:@"url"];
    [array addObject:tpDic];
    
    return array;
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
