//
//  Doctor.swift
//  FindYourDoctor
//
//  Created by Elena Sharipova on 07.05.2023.
//

struct Doctor: Decodable {
    let lastName: String
    let firstName: String
    let medicalSchoolName: String
    let graduationYear: String
    let primarySpecialty: String
    let allSecondarySpecialties: String
    let organizationLegalName: String
    let line1StreetAddress: String
    let line2StreetAddress: String
    let city: String
    let state: String
    let zipCode: String
    let phoneNumber: String
    
    var completeName: String {
        "\(firstName) \(lastName)"
    }
    
    init(lastName: String, firstName: String, medicalSchoolName: String, graduationYear: String, primarySpecialty: String, allSecondarySpecialties: String, organizationLegalName: String, line1StreetAddress: String, line2StreetAddress: String, city: String, state: String, zipCode: String, phoneNumber: String) {
        self.lastName = lastName
        self.firstName = firstName
        self.medicalSchoolName = medicalSchoolName
        self.graduationYear = graduationYear
        self.primarySpecialty = primarySpecialty
        self.allSecondarySpecialties = allSecondarySpecialties
        self.organizationLegalName = organizationLegalName
        self.line1StreetAddress = line1StreetAddress
        self.line2StreetAddress = line2StreetAddress
        self.city = city
        self.state = state
        self.zipCode = zipCode
        self.phoneNumber = phoneNumber
    }
    
    init(from doctorData: [String: Any]) {
        lastName = doctorData["lst_nm"] as? String ?? ""
        firstName = doctorData["frst_nm"] as? String ?? ""
        medicalSchoolName = doctorData["med_sch"] as? String ?? ""
        graduationYear = doctorData["grd_yr"] as? String ?? ""
        primarySpecialty = doctorData["pri_spec"] as? String ?? ""
        allSecondarySpecialties = doctorData["sec_spec_all"] as? String ?? ""
        organizationLegalName = doctorData["org_nm"] as? String ?? ""
        line1StreetAddress = doctorData["adr_ln_1"] as? String ?? ""
        line2StreetAddress = doctorData["adr_ln_2"] as? String ?? ""
        city = doctorData["cty"] as? String ?? ""
        state = doctorData["st"] as? String ?? ""
        zipCode = doctorData["zip"] as? String ?? ""
        phoneNumber = doctorData["phn_numbr"] as? String ?? ""
    }

    static func getDoctors(from value: Any) -> [Doctor] {
        guard let response = value as? [String: Any] else { return [] }
        guard let results = response["results"] as? [[String: Any]] else { return [] }
        return results.map { Doctor(from: $0) }
    }
}

struct Condition: Codable {
    let property: String
    let value: String
    let compareOperator: String
    
    enum CodingKeys: String, CodingKey {
        case property = "property"
        case value = "value"
        case compareOperator = "operator"
    }
}

struct DoctorsApiRequest: Codable {
    let conditions: [Condition]
    let limit: Int
}

struct State: Decodable {
    let title: String
    let code: String
    let flagUrl: String
    
    init(title: String, code: String, flagUrl: String) {
        self.title = title
        self.code = code
        self.flagUrl = flagUrl
    }
    
    init(from stateData: [String: Any], and flagApiUrl: String) {
        title = stateData["name"] as? String ?? ""
        code = stateData["state_code"] as? String ?? ""
        flagUrl = "\(flagApiUrl)/us-\(code.lowercased()).png"
    }
    
    static func getStates(from value: Any, and flagApiUrl: String) -> [State] {
        guard let response = value as? [String: Any] else { return [] }
        guard let data = response["data"] as? [String: Any] else { return [] }
        guard let states = data["states"] as? [[String: Any]] else { return [] }
        return states.map { State(from: $0, and: flagApiUrl) }
    }
}

struct StatesApiRequest: Codable {
    let country: String
}
