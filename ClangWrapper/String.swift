//
//  String.swift
//  libclang_example1
//
//  Created by Hoon H. on 2015/01/21.
//  Copyright (c) 2015 Eonil. All rights reserved.
//

import Foundation

func toSwiftString(s:CXString, disposeCXString:Bool) -> String {
	let	p	=	clang_getCString(s)
	let	s1	=	String(CString: p, encoding: NSUTF8StringEncoding)!
	if disposeCXString {
		clang_disposeString(s)
	}
	return	s1
}