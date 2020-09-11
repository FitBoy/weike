//
//  PersonDetailViewController.m
//  social
//
//  Created by QianYuan on 2020/9/2.
//  Copyright © 2020 QianYuan. All rights reserved.
//
#define LLIVTableViewCellid  @"LLIVTableViewCellid"
#define LIVIVTableViewCellid @"LIVIVTableViewCellid"
#define L_TextTableViewCellid @"L_TextTableViewCellid"
#define LL_LIVTableViewCellid @"LL_LIVTableViewCellid"
#define LTFIVTableViewCellId  @"LTFIVTableViewCellId"
#import "PersonDetailViewController.h"
#import "LLIVTableViewCell.h"
#import "LIVIVTableViewCell.h"
#import "L_TextTableViewCell.h"
#import "LL_LIVTableViewCell.h"
#import "LTFIVTableViewCell.h"
#import "UserModel.h"
#import "DepartChooseViewController.h"
#import <PGDatePickManager.h>
#import "CityViewController.h"
#import "MaintabBarViewController.h"
@interface PersonDetailViewController ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate, UIImagePickerControllerDelegate,DepartChooseViewControllerDelegate,UITextFieldDelegate,PGDatePickerDelegate,CityViewControllerDelegate>{
    NSArray *arr_names;
    NSMutableArray *arr_contents;
    UIImage *image_gonghao;
    NSInteger image_select;
    UserModel *user;
    DepartModel *depart_ ;
    DepartModel *gangwei_;
    City_itemModel *city_model;
    NSString *sex;
}

@property (nonatomic,strong) UITableView *tableV;
@property (nonatomic,strong) UIImagePickerController *picker;

@end

@implementation PersonDetailViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden =NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"完善个人信息";
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"跳过" style:UIBarButtonItemStylePlain target:self action:@selector(Click_tiaoguo)];
    [self.navigationItem setRightBarButtonItem:right];
    city_model = [[City_itemModel alloc]init];
    [self setStaticData];
    self.tableV.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    
}
-(void)setStaticData{
    arr_names  =@[
    @"头像",
    @"工号",
    @"部门",
    @"岗位",
    @"昵称",
    @"性别",
    @"生日",
    @"年龄",
    @"所在城市",
    @"个性签名"
    ];
    
    [EasyLoadingView showLoading];
    
    ///获取个人信息
    [SXTHTTPTool postData:[NSString stringWithFormat:@"%@%@",ServerAdress,auth_me] parameters:@{} success:^(id  _Nonnull responseObject) {
        [EasyLoadingView hidenLoading];
        if ([responseObject[@"code"] integerValue] ==1) {
            NSDictionary *tdic = responseObject[@"data"];
            
            self->user = [UserModel mj_objectWithKeyValues:tdic];
            self->arr_contents = [NSMutableArray arrayWithArray:@[
                self->user.head_image,
                self->user.job_number,
                self->user.department_text,
                self->user.station_text,
                self->user.name,
                self->user.sex,
                self->user.birthday,
                self->user.age,
                self->user.city_text,
                self->user.sign
            ]];
            
            self->depart_ = [[DepartModel alloc]init];
            self->depart_.name = self->user.department_text;
            self->depart_.Id = self->user.department;
            
            self->gangwei_ = [[DepartModel alloc]init];
            self->gangwei_.name = self->user.station_text;
            self->gangwei_.Id = self->user.station;
            self->city_model.Id =self->user.city_id;
            self->city_model.name = self->user.city_text;
            self->sex = self->user.gender;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableV reloadData];
            });
             
        }else{
            [EasyTextView showErrorText:responseObject[@"msg"]];
            self->arr_contents = [NSMutableArray arrayWithArray:@[
            @"",
            @"",
            @"",
            @"",
            @"",
            @"",
            @"",
            @"",
            @"",
            @""
            ]];
            [self.tableV reloadData];
        }
        
    } error:^(NSError * _Nonnull error) {
        
    }];
    
    
    arr_contents = [NSMutableArray arrayWithArray:@[
               @"",
               @"",
               @"",
               @"",
               @"",
               @"",
               @"",
               @"",
               @"",
               @""
               ]];
    image_select = 0;
}
#pragma mark --跳过
-(void)Click_tiaoguo{
    MaintabBarViewController *tabVc = [[MaintabBarViewController alloc]init];
    self.view.window.rootViewController =tabVc;
}
#pragma mark -- 点击头像
-(void)ClickHead{
    image_select =0;
    self.picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    self.picker.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:self.picker animated:YES completion:nil];
    
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info{
    
    [self dismissViewControllerAnimated:YES completion:^{
        dispatch_async(dispatch_get_main_queue(), ^{
       UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
            
            [SXTHTTPTool  postData:[NSString stringWithFormat:@"%@%@",ServerAdress,base64Upload] parameters:@{
                @"imgurl":[self base64FromImage:image]
            } success:^(id  _Nonnull responseObject) {
                if ([responseObject[@"code"] integerValue] ==1) {
                    
                      NSString *data = responseObject[@"data"];
                    if (self->image_select ==0) {
                  LIVIVTableViewCell *cell = [self.tableV cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
                    self->user.avatar = data;
                        [self->arr_contents replaceObjectAtIndex:0 withObject:self->user.head_image];
                        [cell.IV_head sd_setImageWithURL:[NSURL URLWithString:self->user.head_image]];
                  }else{
          self->image_gonghao = image;
           LL_LIVTableViewCell *cell =[self.tableV cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
        cell.IV_img.image = image;
                        }

                }
            } error:^(NSError * _Nonnull error) {
                
            }];
            
        });
        
    }];
    
   
    
    
}


#pragma mark -- 工号的点击
-(void)Click_gonghao{
    image_select =1;
    UIAlertController *alert = [[UIAlertController alloc]init];
    [alert addAction:[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        self.picker.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentViewController:self.picker animated:YES completion:nil];
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        self.picker.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentViewController:self.picker animated:YES completion:nil];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    dispatch_async(dispatch_get_main_queue(), ^{
   [self presentViewController:alert animated:YES completion:nil];
    });
   
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row ==1) {
        return 125;
    }else if (indexPath.row ==9){
        return 95;
    }else{
        return 55;
    }
}
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return arr_names.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row ==0){
        //头像
        LIVIVTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:LIVIVTableViewCellid];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.L_left.text = arr_names[indexPath.row];
        [cell.IV_head sd_setImageWithURL:[NSURL URLWithString:arr_contents[0]]];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ClickHead)];
        [cell.IV_head addGestureRecognizer:tap];
        return cell;
    }else if (indexPath.row ==1){
        ///工号
        LL_LIVTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:LL_LIVTableViewCellid];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        cell.L_left.text = arr_names[indexPath.row];
        cell.TF_right.placeholder= @"请输入工号";
        cell.TF_right.tag =1000+1;
        cell.TF_right.delegate = self;
        cell.TF_right.text =arr_contents[1];
        cell.IV_img.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Click_gonghao)];
        [cell.IV_img addGestureRecognizer:tap];
        [cell setUI];
        return cell;
    }else if (indexPath.row ==2 || indexPath.row ==3 || indexPath.row ==5 || indexPath.row ==6 || indexPath.row ==7 || indexPath.row ==8 ){
        //部门岗位
        LLIVTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:LLIVTableViewCellid];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        cell.L_left.text = arr_names[indexPath.row];
        cell.L_right.text = arr_contents[indexPath.row];
        if (indexPath.row==7) {
            cell.IV_right.hidden = YES;
        }else{
            cell.IV_right.hidden = NO;
        }
        return cell;
    }else if (indexPath.row ==4){
        //昵称
        LTFIVTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:LTFIVTableViewCellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        cell.L_left.text = arr_names[indexPath.row];
        cell.TF_right.placeholder = @"请输入昵称";
        cell.TF_right.delegate = self;
        cell.TF_right.tag=1000+4;
        cell.TF_right.text = arr_contents[indexPath.row];
        return cell;
    }else if (indexPath.row ==9){
        //个性签名
        L_TextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:L_TextTableViewCellid];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        cell.L_left.text = @"个性签名：";
        cell.TF_text.placeholder = @"请输入个性签名";
        cell.TF_text.delegate = self;
        cell.TF_text.tag =1000+9;
        cell.TF_text.text = arr_contents[indexPath.row];
        return cell;
    }else{
        UITableViewCell *cell = [[UITableViewCell alloc]init];
        return cell;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row ==2 || indexPath.row ==3) {
        DepartChooseViewController *Pvc = [[DepartChooseViewController alloc]init];
        Pvc.delegate_depart = self;
        [self.navigationController pushViewController:Pvc animated:YES];
    }else if (indexPath.row ==5){
        UIAlertController *alert = [[UIAlertController alloc]init];
        NSArray *tarr = @[@"保密",@"男",@"女"];
        for (int i=0; i<tarr.count; i++) {
            [alert addAction:[UIAlertAction actionWithTitle:tarr[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self->arr_contents replaceObjectAtIndex:5 withObject:tarr[i]];
                self->sex = [NSString stringWithFormat:@"%d",i];
                [self.tableV reloadData];
            }]];
        }
        
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        
        [self presentViewController:alert animated:YES completion:nil];
        
        
    }else if (indexPath.row ==6){
        
        PGDatePickManager *datePickManager = [[PGDatePickManager alloc]init];
        PGDatePicker *datePicker = datePickManager.datePicker;
        datePicker.delegate = self;
        datePicker.maximumDate = [NSDate now];
        [datePicker setDate:[[NSDate date] dateByAddingTimeInterval:-365*24*60*60 *30]];
        datePicker.datePickerMode = PGDatePickerModeDate;
        dispatch_async(dispatch_get_main_queue(), ^{
             [self presentViewController:datePickManager animated:YES completion:nil];
        });
      
     
        
    }else if (indexPath.row ==8){
       
        CityViewController *Cvc = [[CityViewController alloc]init];
        Cvc.delegate_city = self;
        [self.navigationController pushViewController:Cvc animated:YES];
        
    }
    
    else{
        
    }
}
#pragma mark -- 城市
-(void)getCity:(City_itemModel *)city{
    [arr_contents replaceObjectAtIndex:8 withObject:city.name];
    city_model = city;
    [self.tableV reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:8 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];

}

#pragma mark -- delegate ---depart
-(void)getDepat:(DepartModel *)depart gangwei:(DepartModel *)gangwei{
    depart_ = depart;
    gangwei_ =gangwei;
    [arr_contents replaceObjectAtIndex:2 withObject:depart.name];
    [arr_contents replaceObjectAtIndex:3 withObject:gangwei.name];
    [self.tableV reloadData];
    
}

-(void)datePicker:(PGDatePicker *)datePicker didSelectDate:(NSDateComponents *)dateComponents{
    LLIVTableViewCell *cell =[self.tableV cellForRowAtIndexPath:[NSIndexPath indexPathForRow:6 inSection:0]];
    NSString *str_date = [NSString stringWithFormat:@"%ld-%ld-%ld",dateComponents.year,dateComponents.month,dateComponents.day];
    [arr_contents replaceObjectAtIndex:6 withObject:str_date];
   
    NSDate *now = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy"];
    NSString *year = [formatter stringFromDate:now];
    
    NSInteger age = [year integerValue] - dateComponents.year;
    [arr_contents replaceObjectAtIndex:7 withObject:[NSString stringWithFormat:@"%ld",age]];

    cell.L_right.text = str_date;
    [self.tableV reloadData];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 60;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *View =[[UIView alloc]initWithFrame:CGRectMake(0, 0, MainScreenWidth, 60)];
    View.backgroundColor = [UIColor whiteColor];
    UILabel *tlabel = [[UILabel alloc]init];
    [View addSubview:tlabel];
    [tlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200, 45));
        make.center.mas_equalTo(View);
    }];
    tlabel.backgroundColor = RGBColor(53, 127, 246);
    tlabel.textColor = [UIColor whiteColor];
    tlabel.textAlignment = NSTextAlignmentCenter;
    tlabel.text = @"确定";
    tlabel.layer.masksToBounds =YES;
    tlabel.layer.cornerRadius =22.5;
    tlabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ClickQueding)];
    [tlabel addGestureRecognizer:tap];
    return View;;
    
}

#pragma mark -- 确定
-(void)ClickQueding{
    
    [EasyLoadingView showLoading];
    [SXTHTTPTool postData:[NSString stringWithFormat:@"%@%@",ServerAdress,user_profile] parameters:@{
            @"name":arr_contents[4],
            @"avatar":user.avatar,
            @"job_number":arr_contents[1] ,
            @"department":depart_.Id,
            @"station":gangwei_.Id ,
            @"gender":sex ,
            @"birthday": arr_contents[6],
            @"age":arr_contents[7] ,
            @"city_id": city_model.Id,
            @"sign":arr_contents[9]
    } success:^(id  _Nonnull responseObject) {
        if ([responseObject[@"code"] integerValue] ==1) {
            MaintabBarViewController *tabVc = [[MaintabBarViewController alloc]init];
            self.view.window.rootViewController =tabVc;
        }else{
            [EasyTextView showErrorText:responseObject[@"msg"]];
        }
    } error:^(NSError * _Nonnull error) {
        
    }];
    
}

#pragma mark -- textfield 的协议代理

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    NSInteger  row = textField.tag -1000;
    [arr_contents replaceObjectAtIndex:row withObject:textField.text];
    return YES;
}

#pragma mark -- 懒加载
-(UITableView *)tableV{
    
    if (!_tableV) {
        _tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, MainScreenWidth, MainScreenHeight-SafeAreaBottom) style:UITableViewStyleGrouped];
        [self.view addSubview:_tableV];
        _tableV.delegate =self;
        _tableV.dataSource = self;
        _tableV.showsVerticalScrollIndicator = NO;
        _tableV.showsHorizontalScrollIndicator = NO;
        _tableV.contentInsetAdjustmentBehavior = NO;
        //_tableV.estimatedRowHeight =45;
        [_tableV registerClass:[LLIVTableViewCell class] forCellReuseIdentifier:LLIVTableViewCellid];
        [_tableV registerClass:[LL_LIVTableViewCell class] forCellReuseIdentifier:LL_LIVTableViewCellid];
        [_tableV registerClass:[L_TextTableViewCell class] forCellReuseIdentifier:L_TextTableViewCellid];
        [_tableV registerClass:[LIVIVTableViewCell class] forCellReuseIdentifier:LIVIVTableViewCellid];
        [_tableV registerClass:[LTFIVTableViewCell class] forCellReuseIdentifier:LTFIVTableViewCellId];
        _tableV.contentInset = UIEdgeInsetsMake(0, 0, 0, 0 );
        CGRect frame=CGRectMake(0, 0, 0, CGFLOAT_MIN);
        _tableV.tableHeaderView=[[UIView alloc]initWithFrame:frame];
        
    }
    return _tableV;
}

-(UIImagePickerController *)picker {
    
    if (!_picker) {
        _picker  = [[UIImagePickerController alloc]init];
        _picker.delegate =self;
    }
    return _picker;
}

@end
