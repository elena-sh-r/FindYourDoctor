//
//  NetworkManager.swift
//  FindYourDoctor
//
//  Created by Elena Sharipova on 10.05.2023.
//

import Foundation

enum Link {
    case doctorsAndCliniciansURL
    
    var url: URL {
        switch self {
        case .doctorsAndCliniciansURL:
            return URL(string: "https://data.cms.gov/provider-data/api/1/datastore/query/mj5m-pzi6/0")!
        }
    }
}

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchDoctors(with parameters: ApiRequest, to url: URL, completion: @escaping(Result<[Doctor], NetworkError>) -> Void) {
        guard let encodedJSON = try? JSONEncoder().encode(parameters) else {
            completion(.failure(.noData))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = encodedJSON
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data else {
                completion(.failure(.noData))
                print(error?.localizedDescription ?? "No error description")
                return
            }

            do {
                let doctorsApiResponse = try JSONDecoder().decode(DoctorsApiResponse.self, from: data)
                completion(.success(doctorsApiResponse.results))
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}

