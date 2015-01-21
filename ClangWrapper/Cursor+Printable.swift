//
//  Cursor+Printable.swift
//  ClangWrapper
//
//  Created by Hoon H. on 2015/01/21.
//  Copyright (c) 2015 Eonil. All rights reserved.
//

import Foundation

public extension Cursor {
	public var description:String {
		get {
			let	extras	=	getExtras(self)
			let	extras1	=	extras == nil ? "" : ", \(extras!)"
			return	"\(kind):\(type.kind), [\(spelling)](\(extent))\(extras1)"
		}
	}
}



private func getExtras(c:Cursor) -> String? {
	if c.kind == CursorKind.CXXAccessSpecifier {
	}
	switch c.kind {
	case .CXXAccessSpecifier:	return	"CXXAccessSpecifier = \(c.CXXAccessSpecifier.description)"
	default:					return	nil
	}
}
