//
//  APIClient.swift
//  OEOE
//
//  Created by 송우진 on 4/19/25.
//

import Alamofire
import Foundation

struct EmptyBody: Encodable {}

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
        
        logInfo("🌐 [API REQUEST] \(method.rawValue.uppercased()) \(url.absoluteString)")
        
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
            logResponse(url: url, responseData: response)
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
    
    
    /// body가 없는
    func requestDecodable<T: Decodable>(
            endpoint: APIEndpoint,
            method: Alamofire.HTTPMethod = .get,
            headers: HTTPHeaders? = nil,
            parameters: [String: String]? = nil
        ) async throws -> T {
            try await requestDecodable(
                endpoint: endpoint,
                method: method,
                body: Optional<EmptyBody>.none,
                headers: headers,
                parameters: parameters
            )
        }
    
    func requestVoid<T: Encodable>(
        endpoint: APIEndpoint,
        method: Alamofire.HTTPMethod = .post,
        body: T? = nil,
        headers: HTTPHeaders? = nil,
        parameters: [String: String]? = nil
    ) async throws {
        _ = try await requestData(
            endpoint: endpoint,
            method: method,
            body: body,
            headers: headers,
            parameters: parameters
        )
    }
    
    func requestVoid(
        endpoint: APIEndpoint,
        method: Alamofire.HTTPMethod = .post,
        headers: HTTPHeaders? = nil,
        parameters: [String: String]? = nil
    ) async throws {
        try await requestVoid(
            endpoint: endpoint,
            method: method,
            body: Optional<EmptyBody>.none,
            headers: headers,
            parameters: parameters
        )
    }
    
}

extension APIClient {
    
    private func logResponse(
        url: URL,
        responseData: Data?
    ) {
        var logData: [String: Any] = ["▶️ URL": url.absoluteString]

        if let data = responseData, let jsonString = String(data: data, encoding: .utf8) {
            logData["▶️ Response Data"] = jsonString
        } else {
            logData["▶️ Response Data"] = "(Binary Data)"
        }

        Log.info("📩 [API RESPONSE]", logData)
    }

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
