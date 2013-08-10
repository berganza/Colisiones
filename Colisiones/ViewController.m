//
//  ViewController.m
//  Colisiones
//
//  Created by LLBER on 09/08/13.
//  Copyright (c) 2013 Berganza. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize nota, papelera, mail;


    // Crear nueva nota
- (IBAction)nuevaNota:(id)sender {
    
    nota = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nota.png"]];
    nota.frame = CGRectMake(100, 280, 100, 100);
    [self.view addSubview:nota];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Con imagen UIImageView
    // ...
    
    
    // Con capa CALayer
    UIImage *image = [UIImage imageNamed:@"mailbox.png"];
    mail = [CALayer layer];
    mail.contents = (id)image.CGImage;
    mail.bounds = CGRectMake(0, 0, 100, 100); // image.size.width, image.size.height);
    mail.position = CGPointMake(80, 120);
    
    [self.view.layer addSublayer:mail];
    
}

-(void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch * mitouch = [[event allTouches] anyObject];
    
    CGPoint localizacion = [mitouch locationInView:self.view];
    nota.center = localizacion;
    [self colision];
}

-(void) colision {
    
    // Efecto papelera
    if (CGRectIntersectsRect(nota.frame, papelera.frame)) {
        
        [UIView animateWithDuration:3 animations:^{
            nota.transform = CGAffineTransformMakeScale(0.1, 0.1);
            nota.alpha = 0.2;
            nota.center = papelera.center;
            
            papelera.transform = CGAffineTransformMakeScale(1.5, 1.5);
            papelera.image = [UIImage imageNamed:@"open.png"];
            papelera.transform = CGAffineTransformMakeScale(1, 1);
            
        } completion:^(BOOL finished) {
            
            [nota removeFromSuperview];
            
        }];
    }
    
    
    // Efecto Email
    if (CGRectIntersectsRect(nota.frame, mail.frame)) {
        
        [UIView animateWithDuration:3 animations:^{
            nota.transform = CGAffineTransformMakeScale(0.1, 0.1);
            nota.alpha = 0.2;
            nota.center = mail.position;
            
            mail.borderWidth = 2;
            mail.borderColor = [UIColor cyanColor].CGColor;
            mail.transform = CATransform3DMakeScale(1.2, 1.2, 0);
            
        } completion:^(BOOL finished) {
            
            [nota removeFromSuperview];
            mail.transform = CATransform3DMakeScale(1, 1, 0);
            mail.borderWidth = 0;
            
            MFMailComposeViewController * envio = [[MFMailComposeViewController alloc] init];
            
            if ([MFMailComposeViewController canSendMail]) {
                [envio setToRecipients:[NSArray arrayWithObjects:@"llberganza@gmail.com", nil]];
                [envio setSubject:@"Asunto"];
                [envio setMessageBody:@"Mensaje de prueba \n (Desde el simulador no funciona)" isHTML:NO];
                [envio setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
                [self presentViewController:envio animated:YES completion:nil];
            }
        }];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
