//
//  ViewController.h
//  Colisiones
//
//  Created by LLBER on 09/08/13.
//  Copyright (c) 2013 Berganza. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <QuartzCore/QuartzCore.h>

#import <MessageUI/MessageUI.h>


@interface ViewController : UIViewController


@property (nonatomic, strong) IBOutlet UIImageView * nota;

@property (nonatomic, strong) IBOutlet UIImageView * papelera;

-(void)colision;

@property(nonatomic, strong) CALayer *mail;

- (IBAction)nuevaNota:(id)sender;

@end
