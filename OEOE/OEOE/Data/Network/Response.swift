//
//  Response.swift
//  OEOE
//
//  Created by 송우진 on 4/19/25.
//

struct Response<T: Decodable>: Decodable {
    let data: T?
}
