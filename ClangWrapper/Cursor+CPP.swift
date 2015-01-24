//
//  Cursor+CPP.swift
//  ClangWrapper
//
//  Created by Hoon H. on 2015/01/23.
//  Copyright (c) 2015 Eonil. All rights reserved.
//

import Foundation

public extension Cursor {
	public var isStaticCPPMethod:Bool {
		get {
			return	clang_CXXMethod_isStatic(raw) != 0
		}
	}
//	public var isConstCPPMethod:Bool {
//		get {
//			return	clang_CXXMethod_isConst(raw) != 0
//		}
//	}
}