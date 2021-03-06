//
//  ZBSettingViewController.m
//  ZBNews
//
//  Created by NQ UEC on 16/12/1.
//  Copyright © 2016年 Suzhibin. All rights reserved.
//

#import "ZBSettingViewController.h"
@implementation ZBSettingGroup

@end



@implementation ZBSettingItem
+ (id)itemWithIcon:(NSString *)icon title:(NSString *)title type:(ZBSettingItemType)type
{
    ZBSettingItem *item = [[self alloc] init];
    item.icon = icon;
    item.title = title;
    item.type = type;
    return item;
}
@end



@interface ZBSettingCell()


@property (nonatomic, strong) UIView *rightView;
@property (nonatomic, strong) UILabel *rightLabel;
@property (nonatomic, strong) UIImageView *rightImageView;
@property (nonatomic, strong) UITextField *textField;
@end
@implementation ZBSettingCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setItem:(ZBSettingItem *)item
{
    _item = item;
    
    // 设置数据
    if (item.icon) { self.imageView.image = [UIImage imageNamed:item.icon]; }
    self.textLabel.text = item.title;
    self.textLabel.font = [UIFont systemFontOfSize:15.0];
    //    self.textLabel.textColor = BLACK_COLOR;
    
    if (item.type == ZBSettingItemTypeArrow) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

        // 用默认的选中样式
        self.selectionStyle = UITableViewCellSelectionStyleBlue;
        
    } else if (item.type == ZBSettingItemTypeSwitch) {
  
        [self.rightSwitch setOn:item.isOpenSwitch];
        [self.rightSwitch addTarget:self action:@selector(switchStatusChanged:) forControlEvents:UIControlEventValueChanged];
        // 右边显示开关
        self.accessoryView = self.rightSwitch;
        // 禁止选中
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    } else if (item.type == ZBSettingItemTypeRightText) {
        self.accessoryView   = self.rightLabel;
        self.rightLabel.text = item.rightText;
        self.selectionStyle  = UITableViewCellSelectionStyleBlue;
        
    } else if (item.type == ZBSettingItemTypeArrowWithText) {
        self.accessoryView   = self.rightView;
        self.rightLabel.text = item.rightText;
        self.selectionStyle  = UITableViewCellSelectionStyleBlue;
        
    } else if (item.type == ZBSettingItemTypeTextField) {
        self.accessoryView  = self.textField;
        self.textField.text = item.rightText;
        [self.textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        self.textField.placeholder = item.placeholder;
        self.selectionStyle        = UITableViewCellSelectionStyleNone;
        
    } else if (item.type == ZBSettingItemTypeRightImage) {
        self.accessoryView  = self.photoImageView;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        //[self.photoImageView sd_setImageWithURL:[NSURL URLWithString:item.imageUrl] placeholderImage:[UIImage imageNamed:@"pic_portrait"]];
    } else {
        // 什么也没有，清空右边显示的view
        self.accessoryView = nil;
        // 用默认的选中样式
        self.selectionStyle = UITableViewCellSelectionStyleBlue;
        
    }
}

#pragma mark - SwitchValueChanged

- (void)switchStatusChanged:(UISwitch *)sender
{
    if (self.switchChangeBlock) {
        self.switchChangeBlock(sender.isOn);
    }
}

- (void)textFieldDidChange:(UITextField *)textField
{
    UITextRange * selectedRange = textField.markedTextRange;
    if( selectedRange == nil || selectedRange.empty ){
        //这里取到textfielf.text最后的值 进行检索
        NSLog(@"selectedRange textField.text [%@]", textField.text);
        self.item.rightText = textField.text;
    }
}

- (UIView *)rightView
{
    if (!_rightView) {
        _rightView                  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 150, 44)];
        [_rightView addSubview:self.rightLabel];
       // self.rightImageView.left= self.rightLabel.right+10;
        [_rightView addSubview:self.rightImageView];
    }
    return _rightView;
}
- (UISwitch *)rightSwitch
{
    if (!_rightSwitch) {
        _rightSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, 130, 44)];

    }
    return _rightSwitch;
}
- (UILabel *)rightLabel
{
    if (!_rightLabel) {
        _rightLabel               = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 130, 44)];
        _rightLabel.font          = [UIFont systemFontOfSize:15.0];
       // _rightLabel.textColor     = [UIColor redColor];
        _rightLabel.textAlignment = NSTextAlignmentRight;
    }
    return _rightLabel;
}

- (UIImageView *)rightImageView
{
    if (!_rightImageView) {
        _rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 17, 10, 10)];
       // _rightImageView.image = [UIImage imageNamed:@"sliderMenu_rightArrow"];
    }
    return _rightImageView;
}

- (UIImageView *)photoImageView
{
    if (!_photoImageView) {
        _photoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 15, 50, 50)];
        _photoImageView.userInteractionEnabled = YES;
         _photoImageView.layer.cornerRadius = _photoImageView.frame.size.width/2;
        _photoImageView.layer.masksToBounds = YES;
    }
    return _photoImageView;
}

- (UITextField *)textField
{
    if (!_textField) {
        _textField               = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
        _textField.borderStyle   = UITextBorderStyleNone;
        _textField.textAlignment = NSTextAlignmentRight;
        _textField.font          = [UIFont systemFontOfSize:15.0];
    }
    return _textField;
}

@end



@interface ZBSettingViewController ()

@end

@implementation ZBSettingViewController
/*
- (void)loadView
{
    self.tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame style:UITableViewStyleGrouped];
    self.tableView .delegate = self;
    self.tableView .dataSource = self;

    self.view = self.tableView ;
}
 */
- (void)tableReloadData
{
      [self.tableView reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     self.automaticallyAdjustsScrollViewInsets=NO;
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        self.tableView.estimatedRowHeight = 0;
        self.tableView.estimatedSectionHeaderHeight = 0;
        self.tableView.estimatedSectionFooterHeight = 0;
    }

    _allGroups = [NSMutableArray array];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];//applicationFrame
    self.tableView .delegate = self;
    self.tableView .dataSource = self;
    [self.view addSubview:self.tableView];
   // self.view = self.tableView ;
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _allGroups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    ZBSettingGroup *group = _allGroups[section];
    return group.items.count;
}

#pragma mark 每当有一个cell进入视野范围内就会调用，返回当前这行显示的cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    // 0.用static修饰的局部变量，只会初始化一次
    static NSString *ID = @"Cell";
    
    // 1.拿到一个标识先去缓存池中查找对应的Cell
    _cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    // 2.如果缓存池中没有，才需要传入一个标识创建新的Cell
    if (_cell == nil) {
  
        _cell = [[ZBSettingCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    // 2.取出这行对应的模型（ZFSettingItem）
    ZBSettingGroup *group = _allGroups[indexPath.section];
    _cell.item = group.items[indexPath.row];
    
    __block ZBSettingCell *weakCell = _cell;
    
    _cell.switchChangeBlock = ^ (BOOL on){
        if (weakCell.item.switchBlock) {
            weakCell.item.switchBlock(on);
        }
    };
   
    return _cell;
}

#pragma mark 点击了cell后的操作
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 0.取出这行对应的模型
    ZBSettingGroup *group = _allGroups[indexPath.section];
    ZBSettingItem *item = group.items[indexPath.row];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    // 1.取出这行对应模型中的block代码
    if (item.operation) {
        // 执行block
        item.operation();
    }
}

#pragma mark 返回每一组的header标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    ZBSettingGroup *group = _allGroups[section];
    
    return group.header;
}
#pragma mark 返回每一组的footer标题
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    ZBSettingGroup *group = _allGroups[section];
    
    return group.footer;
}

// 返回section组头的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    ZBSettingGroup *group = _allGroups[section];
    return group.headerHeight;
}

// 返回section组脚的高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    ZBSettingGroup *group = _allGroups[section];
    return group.footerHeight;
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
