//
//  RefQualifierKind.swift
//  ClangWrapper
//
//  Created by Hoon H. on 2015/01/22.
//  Copyright (c) 2015 Eonil. All rights reserved.
//

import Foundation

public enum RefQualifierKind: UInt32 {
	///	No ref-qualifier was provided.
	case None	=	0
	
	///	An lvalue ref-qualifier was provided (&).
	case LValue
	
	///	An rvalue ref-qualifier was provided (&&).
	case RValue
}

extension RefQualifierKind {
	init(raw: CXRefQualifierKind) {
		switch raw.value {
		case CXRefQualifier_None.value:		self	=	None
		case CXRefQualifier_LValue.value:	self	=	LValue
		case CXRefQualifier_RValue.value:	self	=	RValue
		default:
			fatalError("Unknown `CXRefQualifierKind` value: \(raw)")
		}
	}
	var raw:CXRefQualifierKind {
		get {
			switch self {
			case .None:		return	CXRefQualifier_None
			case .LValue:	return	CXRefQualifier_LValue
			case .RValue:	return	CXRefQualifier_RValue
			}
		}
	}
}