//
//  Type.swift
//  ClangWrapper
//
//  Created by Hoon H. on 2015/01/21.
//  Copyright (c) 2015 Eonil. All rights reserved.
//



public struct Type: Equatable {
	public var spelling:String {
		get {
			let	s	=	clang_getTypeSpelling(raw)
			let	s1	=	toSwiftString(s, true)
			return	s1!
		}
	}
	public var kind:TypeKind {
		get {
			return	TypeKind(raw: raw.kind)
		}
	}
	
	public var canonicalType:Type {
		get {
			return	Type(index: index, raw: clang_getCanonicalType(raw))
		}
	}
	public var pointeeType:Type {
		get {
			return	Type(index: index, raw: clang_getPointeeType(raw))
		}
	}
	public var declaration:Cursor {
		get {
			let	r	=	clang_getTypeDeclaration(raw)
			return	Cursor(index: index, raw: r)
		}
	}
	public var resultType:Type {
		get {
			precondition(self.kind != TypeKind.Invalid)
			
			return	Type(index: index, raw: clang_getResultType(raw))
		}
	}
	public var argumentTypes:[Type] {
		get {
			precondition(self.kind != TypeKind.Invalid)
			
			func argtype(i:UInt32) -> Type {
				let	r	=	clang_getArgType(raw, i)
				let	t	=	Type(index: index, raw: r)
				return	t
			}
			let	r	=	clang_getNumArgTypes(raw)
			precondition(r != -1)
			
			let	n	=	UInt32(r)
			return	(0..<n).map(argtype)
		}
	}
	public var isPODType:Bool {
		get {
			return	clang_isPODType(raw) != 0
		}
	}
	public var isConstQualifiedType:Bool {
		get {
			return	clang_isConstQualifiedType(raw) != 0
		}
	}
	public var isVolatileQualifiedType:Bool {
		get {
			return	clang_isConstQualifiedType(raw) != 0
		}
	}
	public var isRestrictQualifiedType:Bool {
		get {
			return	clang_isConstQualifiedType(raw) != 0
		}
	}
	public var CXXRefQualifier:RefQualifierKind {
		get {
			return	RefQualifierKind(raw: clang_Type_getCXXRefQualifier(raw))
		}
	}
	
	////
	
	let	index:UnmanagedIndexRef
	let	raw:CXType
	
	init(index:UnmanagedIndexRef, raw:CXType) {
		self.index	=	index
		self.raw	=	raw
	}
}
public func ==(left:Type, right:Type) -> Bool {
	return	clang_equalTypes(left.raw, right.raw) != 0
}





extension Type: Printable {
	public var description:String {
		get {
			//	TODO:
			//
			//	Missing types (due to several reasons including missing header files)
			//	are defaulted to `int` instead of `Invalid`.
			//
			//	I don't know how to determine whether the type is missing or actually `int`.
			//
			return	spelling
		}
	}
}






//private func mapPrimitiveTypeName(t:TypeKind) -> String? {
//	switch t {
//	case .Void:		return	"void"
//	case .Bool:		return	"bool"
//	case .Char_S:	return	"char"
//	case .Char_U:	return	"unsigned char"
//	case .Int:		return	"int"
//	case .Long:		return	"long"
//	case .LongLong:	return	"long long"
//	default:		return	nil
//	}
//}




