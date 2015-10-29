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
	static func fromRaw(raw r:CXTokenKind) -> TokenKind {
		return	self.init(raw: r)
	}
	
	///	Doesn't work well in Swift 1.2.
	///	Use `fromRaw` instead of.
	init(raw: CXTokenKind) {
		switch raw.rawValue {
		case CXToken_Punctuation.rawValue:
			self	=	Punctuation
		case CXToken_Keyword.rawValue:
			self	=	Keyword
		case CXToken_Identifier.rawValue:
			self	=	Identifier
		case CXToken_Literal.rawValue:
			self	=	Literal
		case CXToken_Comment.rawValue:
			self	=	Comment
		default:
			fatalError("Unknown token-kind constant value: \(raw.rawValue)")
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
