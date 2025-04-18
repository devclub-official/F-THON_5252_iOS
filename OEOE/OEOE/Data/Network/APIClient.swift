//
//  APIClient.swift
//  OEOE
//
//  Created by 송우진 on 4/19/25.
//

import Alamofire
import Foundation

struct APIClient {
    static let shared = APIClient()
    private let session = Session()
    
    /// 단순히 Data만 받고 싶은 경우
    func requestData<T: Encodable>(
        endpoint: APIEndpoint,
        method: Alamofire.HTTPMethod = .get,
        body: T? = nil,
        headers: HTTPHeaders? = nil,
        parameters: [String: String]? = nil
    ) async throws -> Data {
        
        guard var urlComponents = URLComponents(string: endpoint.urlString) else {
            logError("[API ERROR] Invalid URL: \(endpoint.urlString)")
            throw NetworkError.invalidURL
        }
        
        if let parameters {
            urlComponents.queryItems = parameters.map {
                URLQueryItem(
                    name: $0.key,
                    value: $0.value
                )
            }
        }
        
        guard let url = urlComponents.url else {
            logError("[API ERROR] Invalid URL after appending parameters: \(endpoint.urlString)")
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("*/*", forHTTPHeaderField: "Accept")
        
        if let body {
            do {
                request.httpBody = try JSONEncoder().encode(body)
            } catch {
                logError("[API ERROR] Failed to encode request body")
                throw NetworkError.decodingFailed
            }
        }

        do {
            let response = try await session.request(request)
                .validate { request, response, data in
                    return customValidation(
                        request: request,
                        response: response,
                        data: data
                    )
                }
                .serializingDataAsync()
            return response
        } catch {
            logError("❌ [API ERROR] Request Failed - URL: \(endpoint.urlString)\n\(error)")
            throw error
        }
    }
    
    /// Data를 특정 Decodable 타입으로 파싱해서 받고 싶은 경우
    func requestDecodable<T: Decodable, U: Encodable>(
        endpoint: APIEndpoint,
        method: Alamofire.HTTPMethod = .get,
        body: U? = nil,
        headers: HTTPHeaders? = nil,
        parameters: [String: String]? = nil
    ) async throws -> T {
        let data = try await requestData(
            endpoint: endpoint,
            method: method,
            body: body,
            headers: headers,
            parameters: parameters
        )
        do {
            let decoded = try JSONDecoder().decode(T.self, from: data)
            logInfo("✅ [API SUCCESS] Decoded \(T.self) successfully")
            return decoded
        } catch {
            logError("❌ [API ERROR] Decoding Failed - \(T.self)\n\(error)")
            throw NetworkError.decodingFailed
        }
    }
    
}

extension APIClient {

    private func logError(_ message: String) {
        Log.error("🚨 \(message)")
    }

    private func logInfo(_ message: String) {
        Log.info("ℹ️ \(message)")
    }
    
    /// 상태 코드별로 NetworkError를 반환
    private func customValidation(
        request: URLRequest?,
        response: HTTPURLResponse,
        data: Data?
    ) -> Request.ValidationResult {
        let statusCode = response.statusCode
        
        switch statusCode {
        case 200..<300:
            return .success(())
        case 400:
            return .failure(NetworkError.badRequest)
        case 401:
            return .failure(NetworkError.apiKeyInvalid)
        case 429:
            return .failure(NetworkError.tooManyRequests)
        case 500:
            return .failure(NetworkError.serverError)
        default:
            return .failure(NetworkError.custom("Unhandled server error with status code: \(statusCode)"))
        }
    }
}
