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
			return	TypeKind.fromRaw(raw: raw.kind)
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
	public var argumentTypes:[Type]? {
		get {
			precondition(self.kind != TypeKind.Invalid)
			
			func argtype(i:UInt32) -> Type {
				let	r	=	clang_getArgType(raw, i)
				let	t	=	Type(index: index, raw: r)
				return	t
			}
			let	r	=	clang_getNumArgTypes(raw)
			if r == -1 {
				return	nil
			}
//			precondition(r != -1, "This type `\(self)` of kind `\(self.kind)` does not support argument types.")
			
			let	n	=	UInt32(r)
			return	(0..<n).map(argtype)
		}
	}
	
	
	public var isFunctionTypeVariadic:Bool {
		get {
			return	clang_isFunctionTypeVariadic(raw) == 1
		}
	}
	///	Return `true` if the CXType is a POD (plain old data) type, and `false` otherwise.
	public var isPODType:Bool {
		get {
			return	clang_isPODType(raw) != 0
		}
	}
	
	
	///	Return the number of elements of an array or vector type.
	///	If a type is passed in that is not an array or vector type, -1 is returned.
	///
	///	Wrapper: Returns `nil` instead of `-1`.
	public var numberOfElements:Int? {
		get {
			let	r	=	clang_getNumElements(raw)
			if r == -1 {
				return	nil
			}
			return	Int(r)
		}
	}
	public var elementType:Type {
		get {
			return	Type(index: index, raw: clang_getElementType(raw))
		}
	}
	public var arrayElementType:Type {
		get {
			return	Type(index: index, raw: clang_getArrayElementType(raw))
		}
	}
	
	///	Return the array size of a constant array.
	///	If a non-array type is passed in, -1 is returned.
	///
	///	Wrapper: Returns `nil` instead of `-1`.
	public var arraySize:Int? {
		get {
			let	r	=	clang_getArraySize(raw)
			if r == -1 { return nil }
			return	Int(r)
		}
	}
	
	
	
	
	
	
	///	Determine whether a CXType has the "const" qualifier set, without looking through typedefs that may have added "const" at a different level.
	public var isConstQualifiedType:Bool {
		get {
			return	clang_isConstQualifiedType(raw) != 0
		}
	}
	///	Determine whether a CXType has the "volatile" qualifier set, without looking through typedefs that may have added "volatile" at a different level.
	public var isVolatileQualifiedType:Bool {
		get {
			return	clang_isVolatileQualifiedType(raw) != 0
		}
	}
	///	Determine whether a CXType has the "restrict" qualifier set, without looking through typedefs that may have added "restrict" at a different level.
	public var isRestrictQualifiedType:Bool {
		get {
			return	clang_isRestrictQualifiedType(raw) != 0
		}
	}
	public var CXXRefQualifier:RefQualifierKind {
		get {
			return	RefQualifierKind.fromRaw(raw: clang_Type_getCXXRefQualifier(raw))
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




