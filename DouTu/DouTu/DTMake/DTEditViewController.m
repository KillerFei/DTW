//
//  DTEditViewController.m
//  DouTu
//
//  Created by 岳鹏飞 on 2017/3/20.
//  Copyright © 2017年 fly. All rights reserved.
//

#import "DTEditViewController.h"
#import "DTEditBtnView.h"
#import "DTEditFontView.h"
#import "MSColorSelectionView.h"
#import "DTShareView.h"
#import "DTEditTextColorView.h"

@interface DTEditViewController ()<DTEditBtnViewDelegate,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,MSColorViewDelegate,DTShareViewDelegate,DTEditTextColorViewDelegate,DTEditFontViewDelegate>

{
    UIColor *_color;
}
@property (nonatomic, strong) UIView                 *showBackView;
@property (nonatomic, strong) UIImageView            *showView;
@property (nonatomic, strong) DTEditBtnView          *editView;
@property (nonatomic, strong) UIScrollView           *editScrollView;
@property (nonatomic, strong) UITableView            *editTab;
@property (nonatomic, strong) MSColorSelectionView   *bgColorSectionView;
@property (nonatomic, strong) UIView                 *editBgColorView;
@property (nonatomic, strong) UIView                 *editFtView;
@property (nonatomic, strong) UIPanGestureRecognizer *pan;

@property (nonatomic, strong) NSMutableArray         *dataSource;
@property (nonatomic, assign) NSInteger              pageNum;
@property (nonatomic, strong) NSIndexPath            *seleteIndexPath;
@property (nonatomic, strong) NSData                 *picData;
@property (nonatomic, strong) DTBaseModel            *picModel;


@property (nonatomic, strong) DTEditFontView         *fontView;

@property (nonatomic, strong) DTShareView            *shareView;

@property (nonatomic, strong) DTBaseModel            *model;

@property (nonatomic, strong) DTEditTextColorView    *textColorView;

@property (nonatomic, strong) NSString               *gifPath;

@property (nonatomic, strong) UITextView             *textView;

@end

static NSString *const kDTTagCollectionViewCell = @"kDTTagCollectionViewCell";

@implementation DTEditViewController

- (UIView *)showBackView
{
    if (!_showBackView) {
        _showBackView = [[UIView alloc] init];
        _showBackView.userInteractionEnabled = YES;
        _showBackView.backgroundColor = [UIColor whiteColor];
    }
    return _showBackView;
}
- (UIImageView *)showView
{
    if (!_showView) {
        _showView = [[UIImageView alloc] init];
        _showView.userInteractionEnabled = YES;
        _showView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _showView;
}
#pragma mark --------- 编辑面板
- (UIScrollView *)editScrollView
{
    if (!_editScrollView) {
        _editScrollView = [[UIScrollView alloc] init];
        _editScrollView.backgroundColor = [UIColor whiteColor];
        _editScrollView.contentSize = CGSizeMake(KSCREEN_WIDTH*4, 0);
    }
    return _editScrollView;
}
- (UITableView *)editTab
{
    if (!_editTab) {
        _editTab = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _editTab.delegate = self;
        _editTab.dataSource = self;
        [_editTab registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellId"];
        _editTab.tableFooterView = [[UIView alloc] init];
    }
    return _editTab;
}
- (UITextView *)textView
{
    if (!_textView) {
        _textView = [[UITextView alloc] initWithFrame:CGRectZero];
        _textView.backgroundColor     = [UIColor clearColor];
        _textView.font                = DT_Base_TitleFont;
        _textView.textColor           = [UIColor blackColor];
        _textView.layer.cornerRadius  = 2;
        _textView.layer.borderWidth   = 1.f;
        _textView.layer.borderColor   = DT_Base_EdgeColor.CGColor;
        _textView.layer.shadowOpacity = 1;
        _textView.layer.shadowColor   = [UIColor whiteColor].CGColor;
        _textView.layer.shadowOffset  = CGSizeMake(4, 4);
        _textView.layer.shadowRadius  = 5;
        _textView.scrollEnabled       = NO;
        _textView.delegate            = self;
    }
    return _textView;
}
- (UIView *)editBgColorView
{
    if (!_editBgColorView) {
        _editBgColorView = [[UIView alloc] init];
    }
    return _editBgColorView;
}
- (MSColorSelectionView *)bgColorSectionView
{
    if (!_bgColorSectionView) {
        _bgColorSectionView = [[MSColorSelectionView alloc] init];
        _bgColorSectionView.color = self.view.backgroundColor;
        _bgColorSectionView.delegate = self;
        [_bgColorSectionView setSelectedIndex:1 animated:NO];
    }
    return _bgColorSectionView;
}
- (DTShareView *)shareView
{
    if (!_shareView) {
        _shareView = [[DTShareView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _shareView.delegate = self;
    }
    return _shareView;
}
- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];;
    }
    return _dataSource;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpSubViews];
    [self setRightNavItem];
    [self setLeftBackNavItem];
    [self requestData];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:YES];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.tabBarController.tabBar setHidden:NO];
}
- (void)setRightNavItem
{
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setTitle:@"分享" forState:UIControlStateNormal];
    [rightBtn setTitleColor:DT_Nav_TitleColor forState:UIControlStateNormal];
    rightBtn.titleLabel.font = DT_Nav_TitleFont;
    rightBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    rightBtn.frame = CGRectMake(0, 0, 50, 44);
    [rightBtn addTarget:self action:@selector(rightItemAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
}
- (void)rightItemAction
{
    [[UIApplication sharedApplication].keyWindow addSubview:self.shareView];
    if ([_model.mediaType isEqual:0]) {
        
    } else {
        NSArray *gifImg = self.showView.image.images;
        CGFloat durtion = [UIImage sd_animatedGifDurationWithData:[[SDImageCache sharedImageCache] diskImageDataBySearchingAllPathsForKey:_model.gifPath]]/gifImg.count;
        NSMutableArray *imgs = [[NSMutableArray alloc] init];
        for (UIImage *image in gifImg) {
            if (!kStringIsEmpty(_textView.text)) {
                
                NSDictionary *attr = nil;
                if (_textView.backgroundColor != [UIColor clearColor]) {
                    attr = @{NSFontAttributeName:_textView.font, NSForegroundColorAttributeName:_textView.textColor, NSBackgroundColorAttributeName:_textView.backgroundColor,NSStrokeColorAttributeName:[UIColor whiteColor],NSStrokeWidthAttributeName:@-5};
                } else {
                    attr = @{NSFontAttributeName:_textView.font, NSForegroundColorAttributeName:_textView.textColor,NSStrokeColorAttributeName:[UIColor whiteColor],NSStrokeWidthAttributeName:@1};
                }
                UIImage *img = [image addText:_textView.text textRect:_textView.frame withAttributes:attr];
                [imgs addObject:img];
            }
        }
        _gifPath = [UIImage pathWithImages:imgs gifPath:_model.gifPath durtion:durtion];  
        [self.shareView configPic:_gifPath];
    }
}
- (void)setUpSubViews
{
    self.view.backgroundColor = RGB(240, 240, 240);
    
    _color           = DT_Base_EdgeColor;
    _seleteIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    CGFloat imgWidth = 210 * DT_Base_Scale;
    // 添加展示图片
    self.showBackView.frame = CGRectMake(15, 15, imgWidth, imgWidth);
    self.showView.frame     = CGRectMake(0, 0, imgWidth, imgWidth);
    [self.showBackView addSubview:self.showView];
    [self.view addSubview:self.showBackView];
    
    // 添加背景颜色控件
    self.textColorView = [[DTEditTextColorView alloc] initWithFrame:CGRectMake(self.showBackView.right, self.showBackView.top,KSCREEN_WIDTH-self.showBackView.right, self.showBackView.height)];
    self.textColorView.delegate = self;
    [self.view addSubview:self.textColorView];
    
    // 添加平移手势
    _pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    [self.showBackView addGestureRecognizer:_pan];
    
    // 添加选项按钮
    self.editView          = [[DTEditBtnView alloc] initWithFrame:CGRectMake(0, self.showBackView.bottom+15, KSCREEN_WIDTH, 41)];
    self.editView.delegate = self;
    [self.view addSubview:self.editView];
    
    // 添加滑动选项
    CGFloat scrHeight = KSCREEN_HEIGHT-self.editView.bottom-64;
    self.editScrollView.frame         = CGRectMake(0, self.editView.bottom, KSCREEN_WIDTH, scrHeight);
    self.editScrollView.delegate      = self;
    self.editScrollView.pagingEnabled = YES;
    
    // 热门配文
    self.editTab.frame             = CGRectMake(0, 0, KSCREEN_WIDTH, scrHeight);
    // 文字背景
    self.editBgColorView.frame     = CGRectMake(KSCREEN_WIDTH, 0, KSCREEN_WIDTH, scrHeight);
    self.bgColorSectionView.frame  = CGRectMake(0, 0, scrHeight-100, scrHeight-100);
    self.bgColorSectionView.center = CGPointMake((KSCREEN_WIDTH-15-30)/2,scrHeight/2-50);
    CGFloat btnTop    = 20;
    CGFloat btnPace   = 10;
    CGFloat btnHeight = 15;
    CGFloat btnWidth  = 30;
    CGFloat btnLeft   = KSCREEN_WIDTH-15-btnWidth;
    for (int i=0; i<5; i++) {
        UIButton *bgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        bgBtn.frame = CGRectMake(btnLeft, btnTop, btnWidth, btnHeight);
        btnTop = btnTop+btnPace+btnHeight;
        bgBtn.tag = 10000+i;
        bgBtn.layer.masksToBounds = YES;
        bgBtn.layer.cornerRadius  = 5;
        [bgBtn addTarget:self action:@selector(bgBtnAction:) forControlEvents: UIControlEventTouchUpInside];
        switch (i) {
            case 0:
                bgBtn.backgroundColor = [UIColor blackColor];
                break;
            case 1:
                bgBtn.backgroundColor = [UIColor whiteColor];
                bgBtn.layer.borderColor = DT_Base_EdgeColor.CGColor;
                bgBtn.layer.borderWidth = 1;
                break;
            case 2:
                bgBtn.backgroundColor = [UIColor blueColor];
                break;
            case 3:
                bgBtn.backgroundColor = [UIColor greenColor];
                break;
            case 4:
                bgBtn.backgroundColor = [UIColor redColor];
                break;
            default:
                break;
        }
        [self.editBgColorView addSubview:bgBtn];
    }
    self.fontView = [[DTEditFontView alloc] initWithFrame:CGRectMake(KSCREEN_WIDTH*2, 0, KSCREEN_WIDTH, scrHeight)];
    self.fontView.delegate = self;
    
    [self.editScrollView addSubview:self.editTab];
    [self.editBgColorView addSubview:self.bgColorSectionView];
    [self.editScrollView addSubview:self.editBgColorView];
    [self.editScrollView addSubview:self.fontView];
    [self.view addSubview:_editScrollView];
    
    // 添加配文
    [self.showBackView addSubview:self.textView];
}
#pragma mark ----------- setUpShowView
- (void)setUpShowView
{
    
    if ([_model.mediaType isEqualToNumber:@(0)]) {
        [self.showView sd_setImageWithURL:[NSURL safeURLWithString:_model.picPath] placeholderImage:[UIImage imageNamed:@"dt_loadingImg"]];
    } else {
        [self.showView sd_setImageWithURL:[NSURL safeURLWithString:_model.gifPath] placeholderImage:[UIImage imageNamed:@"dt_loadingImg"]];
    }
    [self refreshWithWord:_model.name];
}
- (void)refreshWithWord:(NSString *)word
{
    self.textView.text = word;
    CGSize textSize = [self.textView sizeThatFits:CGSizeMake(self.showBackView.width-20, MAXFLOAT)];
    self.textView.width   = textSize.width;
    self.textView.height  = textSize.height;
    self.textView.centerX = self.showView.width/2;
    self.textView.bottom  = self.showView.height-10;
}
#pragma mark ----------- Request
- (void)requestData
{
    if (!_itemId) {
        return;
    }
    [DTNetManger getDetailWithItemId:_itemId callBack:^(NSError *error, NSArray *response, DTBaseModel *detailModel) {
        
        if (!kArrayIsEmpty(response)) {
            _model = detailModel;
            [self.dataSource removeAllObjects];
            [self.dataSource addObjectsFromArray:response];
            [self.editTab reloadData];
            [self setUpShowView];
        }
    }];
}
#pragma mark ----------- Tableview Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId" forIndexPath:indexPath];
    cell.textLabel.font = DT_Base_TitleFont;
    cell.textLabel.textColor = DT_Base_TitleColor;
    DTBaseModel *model = self.dataSource[indexPath.row];
    cell.textLabel.text = model.word;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DTBaseModel *model = self.dataSource[indexPath.row];
    [self refreshWithWord:model.word];
}
#pragma mark ---------- EditView delegate
- (void)seleteBtnAtIndex:(NSInteger)index
{
    [UIView animateWithDuration:0.3 animations:^{
       
        [self.editScrollView setContentOffset:CGPointMake(index*KSCREEN_WIDTH, 0)];
    }];
}
#pragma mark --------- Scroll  Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger i  = self.editScrollView.contentOffset.x / KSCREEN_WIDTH;
    [self.editView refreshSeleteBtnAtIndex:i];
}
#pragma mark ---------- PanAction 输入框移动
- (void)panAction:(UIPanGestureRecognizer *)panGes
{
    CGPoint transP = [panGes translationInView:self.showBackView];
    //标签允许的最小位置处x
    CGFloat minX = 0;
    //标签允许的最大位置处x
    CGFloat minY = 0;
    CGFloat maxX = self.showBackView.width-self.textView.width;
    CGFloat maxY = self.showBackView.height-self.textView.height;
    switch (panGes.state) {
            
        case UIGestureRecognizerStateChanged: {
            CGRect newFrame = self.textView.frame;
            if (transP.x > 0 ) {
                newFrame.origin.x = MIN(maxX, transP.x + self.textView.left);
            } else {
                newFrame.origin.x = MAX(minX, transP.x + self.textView.left);
            }
            if (transP.y > 0) {
                newFrame.origin.y = MIN(maxY, transP.y + self.textView.top);
            } else {
                newFrame.origin.y = MAX(minY, transP.y + self.textView.top);
            }
            self.textView.frame = newFrame;
            [panGes setTranslation:CGPointZero inView:self.showBackView];
        }
            break;
        default:
            break;
    }
}
#pragma mark ------ textView Delegate 输入框代理
-(void)textViewDidChange:(UITextView *)textView {
    
    CGSize textSize = [self.textView sizeThatFits:CGSizeMake(self.showBackView.width-20, MAXFLOAT)];
    self.textView.width  = textSize.width;
    self.textView.height = textSize.height;
    self.textView.centerX = self.showView.width/2;
    self.textView.bottom  = self.showView.height-10;
}
- (void)colorView:(id<MSColorView>)colorView didChangeColor:(UIColor *)color
{
    self.textView.backgroundColor = color;
}
#pragma mark - BackgroundColor BtnAction 背景颜色
- (void)bgBtnAction:(UIButton *)sender
{
    switch (sender.tag-10000) {
        case 0:
            self.textView.backgroundColor = [UIColor blackColor];
            break;
        case 1:
            self.textView.backgroundColor = [UIColor whiteColor];
            break;
        case 2:
            self.textView.backgroundColor = [UIColor blueColor];
            break;
        case 3:
            self.textView.backgroundColor = [UIColor greenColor];
            break;
        case 4:
            self.textView.backgroundColor = [UIColor redColor];
            break;
        default:
            break;
    }
}
#pragma mark - DTEditTextColorViewDelegate 文字颜色
- (void)didClickButton:(UIButton *)btn AtIndex:(NSInteger)index
{
    if (index == 5) {
        
        if (btn.selected) {
            self.textView.font = [UIFont systemFontOfSize:15];
        } else {
            self.textView.font = [UIFont boldSystemFontOfSize:15];
        }
        btn.selected = !btn.selected;
    } else {
        switch (index) {
            case 0:
                self.textView.textColor = [UIColor blackColor];
                break;
            case 1:
                self.textView.textColor = [UIColor whiteColor];
                break;
            case 2:
                self.textView.textColor = [UIColor blueColor];
                break;
            case 3:
                self.textView.textColor = [UIColor greenColor];
                break;
            case 4:
                self.textView.textColor = [UIColor redColor];
                break;
            default:
                break;
        }
    }
}
#pragma mark - DTShareViewDelegate
- (void)dtShareViewDidClickWXBtn
{
    
}
- (void)dtShareViewDidClickQQBtn
{
    
}
- (void)dtShareViewDidClickDownBtn
{
    [DTFouncManager downLoadPic:_gifPath];
}
- (void)dtShareViewDidClickBackBtn
{
    if (self.shareView && [self.shareView superview]) {
        
        [self.shareView removeFromSuperview];
    }
}
- (void)dtShareViewDidClickBackDIYBtn
{
    if (self.shareView && [self.shareView superview]) {
        
        [self.shareView removeFromSuperview];
    }
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - DTEditFontViewDelegate
- (void)useThisFont:(UIFont *)font
{
    self.textView.font = font;
}
@end
