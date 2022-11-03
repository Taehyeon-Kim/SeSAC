//
//  BaseSessionManager.swift
//  SeSACWeek18
//
//  Created by taekki on 2022/11/03.
//

import Foundation

class BaseSessionManager: URLSessionManager {

    var baseURL: URL?
    var session: URLSession

    lazy var encoder: DataEncoder = JSONEncoder()
    lazy var decoder: DataDecoder = JSONDecoder()

    var parent: URLSessionManager!

    /// Initializes session manager with base URL and configured URLSession.
    init(base url: URL?, session: URLSession) {
        self.session = session
        self.baseURL = url
    }

    func set(encoder: DataEncoder) -> Self {
        self.encoder = encoder
        return self
    }

    func set(decoder: DataDecoder) -> Self {
        self.decoder = decoder
        return self
    }

    /// Returns a builder for construction using URL provided.
    func request(forURL url: URL?) -> URLRequestBuilder {
        URLRequestBuilder(manager: self, url: url ?? self.baseURL)
    }

    /// Returns requested data and response from session.
    func data(for request: URLRequest, completion: @escaping (Result<Data, Error>) -> Void) {

        // print(request)
        // print(session)
        
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in

            if let error = error {
                completion(.failure(error))
                return
            }

            guard let response = response as? HTTPURLResponse else {
                completion(.failure(NetworkError.unknownError))
                return
            }

            guard (200...299).contains(response.statusCode) else {
                completion(.failure(NetworkError.invalidHTTPStatusCode(response.statusCode)))
                return
            }

            guard let data = data else {
                completion(.failure(NetworkError.emptyData))
                return
            }
            //
            // do {
            //
            // } catch {
            //     return .failure(NetworkError.emptyData)
            // }

            completion(.success(data))

        }.resume()
    }
}
