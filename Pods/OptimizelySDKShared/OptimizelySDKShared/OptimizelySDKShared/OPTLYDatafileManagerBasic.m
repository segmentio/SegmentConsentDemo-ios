/****************************************************************************
 * Copyright 2016, Optimizely, Inc. and contributors                        *
 *                                                                          *
 * Licensed under the Apache License, Version 2.0 (the "License");          *
 * you may not use this file except in compliance with the License.         *
 * You may obtain a copy of the License at                                  *
 *                                                                          *
 *    http://www.apache.org/licenses/LICENSE-2.0                            *
 *                                                                          *
 * Unless required by applicable law or agreed to in writing, software      *
 * distributed under the License is distributed on an "AS IS" BASIS,        *
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. *
 * See the License for the specific language governing permissions and      *
 * limitations under the License.                                           *
 ***************************************************************************/

#import "OPTLYDatafileManagerBasic.h"
#ifdef UNIVERSAL
    #import "OPTLYNetworkService.h"
#else
    #import <OptimizelySDKCore/OPTLYNetworkService.h>
#endif

@implementation OPTLYDatafileManagerUtility

+ (BOOL)conformsToOPTLYDatafileManagerProtocol:(Class)instanceClass {
    // compile time check
    BOOL validProtocolDeclaration = [instanceClass conformsToProtocol:@protocol(OPTLYDatafileManager)];
    
    // runtime check
    BOOL implementsDownloadDatafileMethod = [instanceClass instancesRespondToSelector:@selector(downloadDatafile:completionHandler:)];
    BOOL implementsSaveDatafileMethod = [instanceClass instancesRespondToSelector:@selector(saveDatafile:)];
    BOOL implementsGetDatafileMethod = [instanceClass instancesRespondToSelector:@selector(getSavedDatafile)];
    
    return validProtocolDeclaration && implementsDownloadDatafileMethod && implementsSaveDatafileMethod && implementsGetDatafileMethod;
}

+ (NSURL *)projectConfigURLPath:(NSString *)projectId {
    return [OPTLYNetworkService projectConfigURLPath:projectId];
}

@end

@interface OPTLYDatafileManagerBasic ()

@property NSData *savedDatafile;

@end

@implementation OPTLYDatafileManagerBasic

- (void)downloadDatafile:(nonnull NSString *)projectId
       completionHandler:(nullable void (^)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error))completion {
    OPTLYNetworkService *networkService = [OPTLYNetworkService new];
    [networkService downloadProjectConfig:projectId
                             backoffRetry:NO
                        completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                            self.savedDatafile = data;
                            // call the completion handler
                            if (completion != nil) {
                                completion(data, response, error);
                            }
                        }];
}

- (NSData *)getSavedDatafile {
    return self.savedDatafile;
}

- (void)saveDatafile:(NSData *)datafile {
    self.savedDatafile = datafile;
}

@end

@implementation OPTLYDatafileManagerNoOp

- (void)downloadDatafile:(nonnull NSString *)projectId
       completionHandler:(nullable void (^)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error))completion {
    if (completion) {
        completion(nil, nil, nil);
    }
}

- (NSData *)getSavedDatafile {
    return nil;
}

- (void)saveDatafile:(NSData *)datafile {
    return;
}

@end
