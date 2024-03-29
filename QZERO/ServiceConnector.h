//
//  ServiceConnector.h
//  Service Reader
//
//  Created by Divan Visagie on 2012/08/25.
//

#import <Foundation/Foundation.h>

@protocol ServiceConnectorDelegate <NSObject>

-(void)requestReturnedData:(NSData*)data;


@end

@interface ServiceConnector : NSObject <NSURLConnectionDelegate,NSURLConnectionDataDelegate>

@property (strong,nonatomic) id <ServiceConnectorDelegate> delegate;


-(void)postDataToApi:(NSString *)parameterString withURLString:(NSString *)urlString;
-(void)getDataFromApi:(NSString*)Url;
@end
