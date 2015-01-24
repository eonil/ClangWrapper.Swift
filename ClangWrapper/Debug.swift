//
//  Debug.swift
//  ClangWrapper
//
//  Created by Hoon H. on 2015/01/21.
//  Copyright (c) 2015 Eonil. All rights reserved.
//



func debugLog<T>(v:@autoclosure()->T) {
	println("\(v())")
}