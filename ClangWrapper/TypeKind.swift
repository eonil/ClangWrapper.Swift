//
//  TypeKind.swift
//  ClangWrapper
//
//  Created by Hoon H. on 2015/01/21.
//  Copyright (c) 2015 Eonil. All rights reserved.
//



/**
 * @}
 */
    
/**
 * \defgroup CINDEX_TYPES Type information for CXCursors
 *
 * @{
 */

/**
 * \brief Describes the kind of type
 */
public enum TypeKind: UInt32 {
	/**
	* \brief Represents an invalid type (e.g., where no type is available).
	*/
	case Invalid = 0
	
	/**
	* \brief A type whose specific kind is not exposed via this
	* interface.
	*/
	case Unexposed = 1
	
	/* Builtin types */
	case Void = 2
	case Bool = 3
	case Char_U = 4
	case UChar = 5
	case Char16 = 6
	case Char32 = 7
	case UShort = 8
	case UInt = 9
	case ULong = 10
	case ULongLong = 11
	case UInt128 = 12
	case Char_S = 13
	case SChar = 14
	case WChar = 15
	case Short = 16
	case Int = 17
	case Long = 18
	case LongLong = 19
	case Int128 = 20
	case Float = 21
	case Double = 22
	case LongDouble = 23
	case NullPtr = 24
	case Overload = 25
	case Dependent = 26
	case ObjCId = 27
	case ObjCClass = 28
	case ObjCSel = 29
//	case FirstBuiltin = case Void
//	case LastBuiltin  = case ObjCSel
	
	case Complex = 100
	case Pointer = 101
	case BlockPointer = 102
	case LValueReference = 103
	case RValueReference = 104
	case Record = 105
	case Enum = 106
	case Typedef = 107
	case ObjCInterface = 108
	case ObjCObjectPointer = 109
	case FunctionNoProto = 110
	case FunctionProto = 111
	case ConstantArray = 112
	case Vector = 113
	case IncompleteArray = 114
	case VariableArray = 115
	case DependentSizedArray = 116
	case MemberPointer = 117
	
	
};






internal extension TypeKind {
	static func fromRaw(raw r:CXTypeKind) -> TypeKind {
		return	self(raw: r)
	}
	///	Doesn't work well in Swift 1.2.
	///	Use `fromRaw` instead of.
	init(raw: CXTypeKind) {
		self	=	TypeKind(rawValue: raw.value)!
	}
	var raw:CXTypeKind {
		get {
			return	CXTypeKind(self.rawValue)
		}
	}
}
public extension TypeKind {
	public static var FirstBuiltin:TypeKind {
		get {
			return	Void
		}
	}
	public static var LastBuiltin:TypeKind {
		get {
			return	ObjCSel
		}
	}
}

extension TypeKind {
	public var spelling:String {
		get {
			let	s	=	clang_getTypeKindSpelling(raw)
			let	s1	=	toSwiftString(s, true)
			return	s1!
		}
	}
}











