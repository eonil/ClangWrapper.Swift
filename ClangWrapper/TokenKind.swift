//
//  TokenKind.swift
//  ClangWrapper
//
//  Created by Hoon H. on 2015/01/21.
//  Copyright (c) 2015 Eonil. All rights reserved.
//




/**
* \brief Describes a kind of token.
*/
public enum TokenKind: UInt32 {
	/**
	* \brief A token that contains some kind of punctuation.
	*/
	case Punctuation
	
	/**
	* \brief A language keyword.
	*/
	case Keyword
	
	/**
	* \brief An identifier (that is not a keyword).
	*/
	case Identifier
	
	/**
	* \brief A numeric, string, or character literal.
	*/
	case Literal
	
	/**
	* \brief A comment.
	*/
	case Comment
}

extension TokenKind {
	init(raw: CXTokenKind) {
		switch raw.value {
		case CXToken_Punctuation.value:
			self	=	Punctuation
		case CXToken_Keyword.value:
			self	=	Keyword
		case CXToken_Identifier.value:
			self	=	Identifier
		case CXToken_Literal.value:
			self	=	Literal
		case CXToken_Comment.value:
			self	=	Comment
		default:
			fatalError("Unknown token-kind constant value: \(raw.value)")
		}
	}
	var raw:CXTokenKind {
		get {
			switch self {
			case .Punctuation:
				return	CXToken_Punctuation
			case .Keyword:
				return	CXToken_Keyword
			case .Identifier:
				return	CXToken_Identifier
			case .Literal:
				return	CXToken_Literal
			case .Comment:
				return	CXToken_Comment
			}
		}
	}
}
