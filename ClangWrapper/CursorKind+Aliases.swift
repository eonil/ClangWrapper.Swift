//
//  CursorKind+Aliases.swift
//  libclang_example1
//
//  Created by Hoon H. on 2015/01/21.
//  Copyright (c) 2015 Eonil. All rights reserved.
//

import Foundation

extension CursorKind {
//	case FirstDecl                     = UnexposedDecl,
	static var FirstDecl:CursorKind {
		get {
			return	UnexposedDecl
		}
	}
	
//	case LastDecl                      = CXXAccessSpecifier,
	static var LastDecl:CursorKind {
		get {
			return	CXXAccessSpecifier
		}
	}
	
//	case ObjCSuperClassRef             = 40
	static var ObjCSuperClassRef:CursorKind {
		get {
			return	CursorKind(rawValue: 40)!
		}
	}
	
//	case LastRef                       = VariableRef,
	static var LastRef:CursorKind {
		get {
			return	VariableRef
		}
	}
	
//	case InvalidFile                   = 70
	static var InvalidFile:CursorKind {
		get {
			return	CursorKind(rawValue: 70)!
		}
	}
	
//	case LastInvalid                   = InvalidCode,
	static var LastInvalid:CursorKind {
		get {
			return	InvalidCode
		}
	}
	
//	
//	/**
//	* \brief An expression whose specific kind is not exposed via this
//	* interface.
//	*
//	* Unexposed expressions have the same operations as any other kind
//	* of expression; one can extract their location information,
//	* spelling, children, etc. However, the specific kind of the
//	* expression is not reported.
//	*/
//	case UnexposedExpr                 = 100
	static var UnexposedExpr:CursorKind {
		get {
			return	CursorKind(rawValue: 100)!
		}
	}
	
//	
//	case LastExpr                      = ObjCSelfExpr,
	static var LastExpr:CursorKind {
		get {
			return	ObjCSelfExpr
		}
	}
	
	
//	
//	/**
//	* \brief A statement whose specific kind is not exposed via this
//	* interface.
//	*
//	* Unexposed statements have the same operations as any other kind of
//	* statement; one can extract their location information, spelling,
//	* children, etc. However, the specific kind of the statement is not
//	* reported.
//	*/
//	case UnexposedStmt                 = 200
	static var UnexposedStmt:CursorKind {
		get {
			return	CursorKind(rawValue: 200)!
		}
	}
	
//	
//	case AsmStmt                       = GCCAsmStmt,
	static var AsmStmt:CursorKind {
		get {
			return	GCCAsmStmt
		}
	}
	
//	
//	case LastStmt                      = OMPTeamsDirective,
	static var LastStmt:CursorKind {
		get {
			return	OMPTeamsDirective
		}
	}
	
//	
//	/**
//	* \brief An attribute whose specific kind is not exposed via this
//	* interface.
//	*/
//	case UnexposedAttr                 = 400
	static var UnexposedAttr:CursorKind {
		get {
			return	CursorKind(rawValue: 400)!
		}
	}
	
//	
//	case LastAttr                      = CUDASharedAttr,
	static var LastAttr:CursorKind {
		get {
			return	CUDASharedAttr
		}
	}
	
	
//	
//	case MacroInstantiation            = MacroExpansion,
	static var MacroInstantiation:CursorKind {
		get {
			return	MacroExpansion
		}
	}
	
	
//	
//	case FirstPreprocessing            = PreprocessingDirective,
	static var FirstPreprocessing:CursorKind {
		get {
			return	PreprocessingDirective
		}
	}
	
	
//	case LastPreprocessing             = InclusionDirective,
	static var LastPreprocessing:CursorKind {
		get {
			return	InclusionDirective
		}
	}
	
	
//	
//	case FirstExtraDecl                = ModuleImportDecl,
	static var FirstExtraDecl:CursorKind {
		get {
			return	ModuleImportDecl
		}
	}
	
	
//	case LastExtraDecl                 = ModuleImportDecl
	static var LastExtraDecl:CursorKind {
		get {
			return	ModuleImportDecl
		}
	}
	
	
//	

}





