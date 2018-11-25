//
//  ViewController.m
//  PhotoApp
//
//  Created by Sidharth Juyal on 24/11/2018.
//  Copyright © 2018 Sidharth Juyal. All rights reserved.
//

#import "ViewController.h"
#import <UIKit/UIKit.h>
#import "PAPhotoapp.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    PAPhotoapp *app = [PAPhotoapp create];
    self.label.text = [app getPhotoapp];
}


@end
