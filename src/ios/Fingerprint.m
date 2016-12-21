#import "Fingerprint.h"
#import <Cordova/CDV.h>
#import <LocalAuthentication/LocalAuthentication.h>

@implementation Fingerprint

- (void) authenticate:(CDVInvokedUrlCommand*)command {
    NSString *callbackId = command.callbackId;
    
    LAContext *authContext = [[LAContext alloc] init];
    NSString *reason = @"Authentication";
    __block CDVPluginResult* result = nil;
    
    NSDictionary *inputParameters = [command.arguments objectAtIndex:0];
    if(inputParameters != nil) {
        NSString *clientId = [inputParameters objectForKey:@"clientId"];
        if(clientId != nil) {
            reason = [NSString stringWithString:clientId];
        }
    }
    
    [authContext evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                localizedReason:reason
                          reply:^(BOOL success, NSError *error) {
                              if (success) {
                                  // User authenticated successfully
                                  result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
                              } else {
                                  NSMutableDictionary* errorObj = [NSMutableDictionary dictionaryWithCapacity:2];
                                  [errorObj setObject:[error localizedDescription] forKey:@"message"];
                                  switch (error.code) {
                                      case LAErrorUserCancel:
                                          [errorObj setObject:@"userCancelled" forKey:@"eventId"];
                                          break;
                                      default:
                                          [errorObj setObject:@"genericError" forKey:@"eventId"];
                                          break;
								  }
                                  // User did not authenticate successfully, returning an appropriate message
                                  result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsDictionary:errorObj];
                              }

                              [self.commandDelegate sendPluginResult:result callbackId:callbackId];
                          }];
}

- (void) isAvailable:(CDVInvokedUrlCommand*)command {
    NSString *callbackId = command.callbackId;
    
    LAContext *authContext = [[LAContext alloc] init];
    NSError *authError = nil;
    CDVPluginResult* result = nil;
    
    if ([authContext canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&authError]) {
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    } else {
        // Something went wrong evaluating policy. Returning an appropriate message
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:[authError localizedDescription]];
    }
    
    [self.commandDelegate sendPluginResult:result callbackId:callbackId];
}

@end
