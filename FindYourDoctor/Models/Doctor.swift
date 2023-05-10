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
    
    enum CodingKeys: String, CodingKey {
        case lastName = "lst_nm"
        case firstName = "frst_nm"
        case medicalSchoolName = "med_sch"
        case graduationYear = "grd_yr"
        case primarySpecialty = "pri_spec"
        case allSecondarySpecialties = "sec_spec_all"
        case organizationLegalName = "org_nm"
        case line1StreetAddress = "adr_ln_1"
        case line2StreetAddress = "adr_ln_2"
        case city = "cty"
        case state = "st"
        case zipCode = "zip"
        case phoneNumber = "phn_numbr"
    }
}

struct DoctorsApiResponse: Decodable {
    let results: [Doctor]
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

struct ApiRequest: Codable {
    let conditions: [Condition]
    let limit: Int
}
