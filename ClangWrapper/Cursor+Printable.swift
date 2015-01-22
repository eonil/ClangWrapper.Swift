//
//  Cursor+Printable.swift
//  ClangWrapper
//
//  Created by Hoon H. on 2015/01/21.
//  Copyright (c) 2015 Eonil. All rights reserved.
//

import Foundation

extension Cursor: Printable {
	public var description:String {
		get {
			let	extras	=	getExtras(self)
			let	extras1	=	extras == nil ? "" : ", \(extras!)"
			return	"\(kind):\(type), [\(spelling)](\(extent))\(extras1)"
		}
	}
}



private func getExtras(c:Cursor) -> String? {
	if c.kind == CursorKind.CXXAccessSpecifier {
	}
	switch c.kind {
	case .CXXAccessSpecifier:	return	"CXXAccessSpecifier = \(c.CXXAccessSpecifier.description)"
	case .EnumDecl:				return	"underlying type = \(c.enumDeclarationIntegerType)"
	case .EnumConstantDecl:		return	"constant value = \(c.enumConstantDeclarationValue), constant unsigned value = \(c.enumConstantDeclarationUnsignedValue)"
//	case .CXXMethod:
//		let	a	=	c.argumentCursors.map({ x in x.spelling })
//		let	b	=	join(", ", a)
//		return	"(\(b)) -> \(c.resultType)"
	default:					return	nil
	}
}
