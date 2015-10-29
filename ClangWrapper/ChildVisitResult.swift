//
//  ChildVisitResult.swift
//  ClangWrapper
//
//  Created by Hoon H. on 2015/01/21.
//  Copyright (c) 2015 Eonil. All rights reserved.
//


/**
* \brief Describes how the traversal of the children of a particular
* cursor should proceed after visiting a particular child cursor.
*
* A value of this enumeration type should be returned by each
* \c CXCursorVisitor to indicate how clang_visitChildren() proceed.
*/
public enum ChildVisitResult: UInt32 {
	/**
	* \brief Terminates the cursor traversal.
	*/
	case Break
	/**
	* \brief Continues the cursor traversal with the next sibling of
	* the cursor just visited, without visiting its children.
	*/
	case Continue
	/**
	* \brief Recursively traverse the children of this cursor, using
	* the same visitor and client data.
	*/
	case Recurse
}








internal extension ChildVisitResult {
	init(raw: CXChildVisitResult) {
		switch raw.rawValue {
		case CXChildVisit_Break.rawValue:
			self	=	Break
			
		case CXChildVisit_Continue.rawValue:
			self	=	Continue
			
		case CXChildVisit_Recurse.rawValue:
			self	=	Recurse
			
		default:
			fatalError("Unknown `CXChildVisitResult` constant value.")
		}
	}
	
	var raw:CXChildVisitResult {
		get {
			switch self {
			case .Break:		return	CXChildVisit_Break
			case .Continue:		return	CXChildVisit_Continue
			case .Recurse:		return	CXChildVisit_Recurse
			}
		}
	}
}













