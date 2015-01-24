//
//  TypeKind+Stringification.swift
//  ClangWrapper
//
//  Created by Hoon H. on 2015/01/21.
//  Copyright (c) 2015 Eonil. All rights reserved.
//





extension TypeKind: Printable {
	public var description:String {
		get {
			let	a	=	[firstNameOf(self)] + aliasesOf(self)
			return	join("/", a)
		}
	}
}





private func aliasesOf(v:TypeKind) -> [String] {
	if v == TypeKind.FirstBuiltin {
		return	["FirstBuiltin"]
	}
	if v == TypeKind.LastBuiltin {
		return	["LastBuiltin"]
	}
	return	[]
}

private func firstNameOf(v:TypeKind) -> String {
	switch v {
	case TypeKind.Invalid: return "Invalid"
	case TypeKind.Unexposed: return "Unexposed"
	case TypeKind.Void: return "Void"
	case TypeKind.Bool: return "Bool"
	case TypeKind.Char_U: return "Char_U"
	case TypeKind.UChar: return "UChar"
	case TypeKind.Char16: return "Char16"
	case TypeKind.Char32: return "Char32"
	case TypeKind.UShort: return "UShort"
	case TypeKind.UInt: return "UInt"
	case TypeKind.ULong: return "ULong"
	case TypeKind.ULongLong: return "ULongLong"
	case TypeKind.UInt128: return "UInt128"
	case TypeKind.Char_S: return "Char_S"
	case TypeKind.SChar: return "SChar"
	case TypeKind.WChar: return "WChar"
	case TypeKind.Short: return "Short"
	case TypeKind.Int: return "Int"
	case TypeKind.Long: return "Long"
	case TypeKind.LongLong: return "LongLong"
	case TypeKind.Int128: return "Int128"
	case TypeKind.Float: return "Float"
	case TypeKind.Double: return "Double"
	case TypeKind.LongDouble: return "LongDouble"
	case TypeKind.NullPtr: return "NullPtr"
	case TypeKind.Overload: return "Overload"
	case TypeKind.Dependent: return "Dependent"
	case TypeKind.ObjCId: return "ObjCId"
	case TypeKind.ObjCClass: return "ObjCClass"
	case TypeKind.ObjCSel: return "ObjCSel"
	case TypeKind.Complex: return "Complex"
	case TypeKind.Pointer: return "Pointer"
	case TypeKind.BlockPointer: return "BlockPointer"
	case TypeKind.LValueReference: return "LValueReference"
	case TypeKind.RValueReference: return "RValueReference"
	case TypeKind.Record: return "Record"
	case TypeKind.Enum: return "Enum"
	case TypeKind.Typedef: return "Typedef"
	case TypeKind.ObjCInterface: return "ObjCInterface"
	case TypeKind.ObjCObjectPointer: return "ObjCObjectPointer"
	case TypeKind.FunctionNoProto: return "FunctionNoProto"
	case TypeKind.FunctionProto: return "FunctionProto"
	case TypeKind.ConstantArray: return "ConstantArray"
	case TypeKind.Vector: return "Vector"
	case TypeKind.IncompleteArray: return "IncompleteArray"
	case TypeKind.VariableArray: return "VariableArray"
	case TypeKind.DependentSizedArray: return "DependentSizedArray"
	case TypeKind.MemberPointer: return "MemberPointer"
	}
}






