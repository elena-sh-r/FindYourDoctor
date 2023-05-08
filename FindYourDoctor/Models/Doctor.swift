//
//  Doctor.swift
//  FindYourDoctor
//
//  Created by Elena Sharipova on 07.05.2023.
//

struct Doctor: Decodable {
    let lst_nm: String
    let frst_nm: String
    let med_sch: String
    let grd_yr: String
    let pri_spec: String
    let sec_spec_all: String
    let telehlth: String
    let org_nm: String
    let adr_ln_1: String
    let adr_ln_2: String
    let cty: String
    let st: String
    let zip: String
    let phn_numbr: String
}

struct DoctorsApiResponse: Decodable {
    let results: [Doctor]
}
