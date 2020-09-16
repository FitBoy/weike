//
//  BaseViewController.m
//  social
//
//  Created by QianYuan on 2020/8/31.
//  Copyright © 2020 QianYuan. All rights reserved.
//

#import "BaseViewController.h"
#import <SGQRCode.h>
#import "WCQRCodeVC.h"
#import "FB_WebViewController.h"
@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

}

-(void)clearLocalData{
    [userDefault removeObjectForKey:user_userId];
    [userDefault removeObjectForKey:user_phone];
    [userDefault removeObjectForKey:user_token];
    [userDefault synchronize];
}

-(void)saoyisao{
   
    WCQRCodeVC *WCvc = [[WCQRCodeVC alloc]init];
    [self QRCodeScanVC:WCvc];
    
}
#pragma mark -- 类型：1=平台介绍，2=用户协议，3=隐私协议，4=平台行为规范,5=使用帮助
-(void)jumpWebVcWithtype:(NSString*)type{
    
    NSDictionary *tdic = @{
         @"type":type
    };
    
    [SXTHTTPTool postData:[NSString stringWithFormat:@"%@%@",ServerAdress,index_page] parameters:tdic success:^(id  _Nonnull responseObject) {
        if ([responseObject[@"code"] integerValue] ==1) {
                       dispatch_async(dispatch_get_main_queue(), ^{
                           FB_WebViewController *Wvc = [[FB_WebViewController alloc]init];
                           Wvc.nav_title =  responseObject[@"data"][@"title"];
                           Wvc.html = responseObject[@"data"][@"content"];
                           [self.navigationController pushViewController:Wvc animated:YES];
                       });
                   }else{
                       [EasyTextView showErrorText:responseObject[@"msg"]];
                   }
    } error:^(NSError * _Nonnull error) {
        
    }];
    
   
}

-(void)UploadImages:(NSArray*)image block:(void (^)(BOOL isSuccess ,NSString *tstr))block{
    
  [EasyLoadingView showLoading];
   
   NSMutableString *str_imgs = [NSMutableString string];
   for (int i=0; i<image.count; i++) {
         NSString *tstr = [self base64FromImage:image[i]];
       if (i==image.count-1) {
         
           [str_imgs appendString:tstr];
       }else{
           [str_imgs appendFormat:@"%@-",tstr];
       }
   }
   
   [SXTHTTPTool postData:[NSString stringWithFormat:@"%@%@",ServerAdress,@"/api/multiBase64Upload"] parameters:@{
       @"imgurl":str_imgs
   } success:^(id  _Nonnull responseObject) {
       if ([responseObject[@"code"] integerValue] ==1) {
           //再次上传反馈信息
           block(YES,responseObject[@"data"][@"str"]);
       }else{
           block(NO,@"");
           [EasyTextView showErrorText:responseObject[@"msg"]];
       }
   } error:^(NSError * _Nonnull error) {
       
   }];
    
    
}


- (BOOL)isPhoneNumWithPhone:(NSString *)phone
{
    
    NSString *phoneRegex1=@"1[3456789]([0-9]){9}";
    NSPredicate *phoneTest1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex1];
    return [phoneTest1 evaluateWithObject:phone];
}

-(NSString *)base64FromImage:(UIImage *)image{
    
    NSData *data = UIImageJPEGRepresentation(image, 0.05f);
    NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return encodedImageStr;
}


- (void)QRCodeScanVC:(UIViewController *)scanVC {
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device) {
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        switch (status) {
                case AVAuthorizationStatusNotDetermined: {
                    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                        if (granted) {
                            dispatch_sync(dispatch_get_main_queue(), ^{
                                [self.navigationController pushViewController:scanVC animated:YES];
                            });
                            NSLog(@"用户第一次同意了访问相机权限 - - %@", [NSThread currentThread]);
                        } else {
                            NSLog(@"用户第一次拒绝了访问相机权限 - - %@", [NSThread currentThread]);
                        }
                    }];
                    break;
                }
                case AVAuthorizationStatusAuthorized: {
                    [self.navigationController pushViewController:scanVC animated:YES];
                    break;
                }
                case AVAuthorizationStatusDenied: {
                    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请去-> [设置 - 隐私 - 相机 - SGQRCodeExample] 打开访问开关" preferredStyle:(UIAlertControllerStyleAlert)];
                    UIAlertAction *alertA = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                        
                    }];
                    
                    [alertC addAction:alertA];
                    [self presentViewController:alertC animated:YES completion:nil];
                    break;
                }
                case AVAuthorizationStatusRestricted: {
                    NSLog(@"因为系统原因, 无法访问相册");
                    break;
                }
                
            default:
                break;
        }
        return;
    }
    
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"未检测到您的摄像头" preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *alertA = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertC addAction:alertA];
    [self presentViewController:alertC animated:YES completion:nil];
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
