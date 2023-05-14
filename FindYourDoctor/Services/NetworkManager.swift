//
//  NetworkManager.swift
//  FindYourDoctor
//
//  Created by Elena Sharipova on 10.05.2023.
//

import Foundation
import Alamofire

enum Link {
    case doctorsAndCliniciansURL
    case statesURL
    case stateFlag
    
    var url: URL {
        switch self {
        case .doctorsAndCliniciansURL:
            return URL(string: "https://data.cms.gov/provider-data/api/1/datastore/query/mj5m-pzi6/0")!
        case .statesURL:
            return URL(string: "https://countriesnow.space/api/v0.1/countries/states")!
        case .stateFlag:
            return URL(string: "https://flagcdn.com/256x192")!
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
    
    func fetchStates(from url: URL, with data: StatesApiRequest, completion: @escaping(Result<[State], AFError>) -> Void) {
        AF.request(url, method: .post, parameters: data)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    let states = State.getStates(from: value, and: Link.stateFlag.url.absoluteString)
                    completion(.success(states))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func fetchData(from url: String, completion: @escaping(Result<Data, AFError>) -> Void) {
        AF.request(url)
            .validate()
            .responseData { dataResponse in
                switch dataResponse.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func fetchDoctors(from url: URL, with data: Parameters, completion: @escaping(Result<[Doctor], AFError>) -> Void) {
        AF.request(url, method: .post, parameters: data, encoding: JSONEncoding.default)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    let doctors = Doctor.getDoctors(from: value)
                    completion(.success(doctors))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}

