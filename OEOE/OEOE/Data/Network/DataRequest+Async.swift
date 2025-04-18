//
//  DataRequest+Async.swift
//  OEOE
//
//  Created by 송우진 on 4/19/25.
//

import Alamofire
import Foundation

extension DataRequest {
    /// Alamofire의 DataRequest를 Async/Await으로 사용하기 위한 확장
    func serializingDataAsync() async throws -> Data {
        try await withCheckedThrowingContinuation { continuation in
            self.responseData { response in
                switch response.result {
                case .success(let data):
                    continuation.resume(returning: data)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
