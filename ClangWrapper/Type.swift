//
//  Type.swift
//  ClangWrapper
//
//  Created by Hoon H. on 2015/01/21.
//  Copyright (c) 2015 Eonil. All rights reserved.
//

import Foundation

public struct Type {
	public var kind:TypeKind {
		get {
			return	TypeKind(raw: raw.kind)
		}
	}
	
	////
	
	let	raw:CXType
	
	init(raw:CXType) {
		self.raw	=	raw
	}
}





extension Type: Printable {
	public var description:String {
		get {
			return	"(Type: kind = \(kind))"
		}
	}
}