//
//  CCharArrayOfCCharArray.swift
//  ClangWrapper
//
//  Created by Hoon H. on 2015/01/21.
//  Copyright (c) 2015 Eonil. All rights reserved.
//

import Foundation




func aaa<T>(strings:[String], block:(UnsafePointer<UnsafePointer<Int8>>)->T) -> T {
	///	Keep this in memory until the `block` to be finished.
	let	a	=	strings.map { (s:String) -> NSMutableData in
		let	b	=	s.cStringUsingEncoding(NSUTF8StringEncoding)!
		assert(b[b.endIndex-1] == 0)
		return	NSData.fromCCharArray(b).mutableCopy() as! NSMutableData
	}
	
	let	a1	=	a.map { (d:NSMutableData) -> UnsafePointer<Int8> in
		return	UnsafePointer<Int8>(d.mutableBytes)
		} + [nil as UnsafePointer<Int8>]
	
	return	a1.withUnsafeBufferPointer { (p:UnsafeBufferPointer<UnsafePointer<Int8>>) -> T in
		return	block(p.baseAddress)
	}
}




///	Copied from https://github.com/Eonil/PseudoTeletypewriter.Swift/blob/master/BSD/BSD/BSD.swift
///	Apply any patches to there.
///
///	Generates proper pointer arrays for `exec~` family calls.
///	Terminatin `NULL` is required for `exec~` family calls.
func withCPointerToNullTerminatingCArrayOfCStrings(strings:[String], block:(UnsafePointer<UnsafeMutablePointer<Int8>>)->()) {
	///	Keep this in memory until the `block` to be finished.
	let	a	=	strings.map { (s:String) -> NSMutableData in
		let	b	=	s.cStringUsingEncoding(NSUTF8StringEncoding)!
		assert(b[b.endIndex-1] == 0)
		return	NSData.fromCCharArray(b).mutableCopy() as! NSMutableData
	}
	
	let	a1	=	a.map { (d:NSMutableData) -> UnsafeMutablePointer<Int8> in
		return	UnsafeMutablePointer<Int8>(d.mutableBytes)
		} + [nil as UnsafeMutablePointer<Int8>]
	
	a1.withUnsafeBufferPointer { (p:UnsafeBufferPointer<UnsafeMutablePointer<Int8>>) -> () in
		block(p.baseAddress)
	}
}





private extension NSData {
	func toUInt8Array() -> [UInt8] {
		let	p	=	self.bytes
		let	p1	=	UnsafePointer<UInt8>(p)
		
		var	bs	=	[] as [UInt8]
		for i in 0..<self.length {
			bs.append(p1[i])
		}
		
		return	bs
	}
	func toString() -> String {
		return	NSString(data: self, encoding: NSUTF8StringEncoding)! as String
	}
	class func fromUInt8Array(bs:[UInt8]) -> NSData {
		var	r	=	nil as NSData?
		bs.withUnsafeBufferPointer { (p:UnsafeBufferPointer<UInt8>) -> () in
			let	p1	=	UnsafePointer<Void>(p.baseAddress)
			r		=	NSData(bytes: p1, length: p.count)
		}
		return	r!
	}
	
	///	Assumes `cCharacters` is C-string.
	class func fromCCharArray(cCharacters:[CChar]) -> NSData {
		precondition(cCharacters.count == 0 || cCharacters[cCharacters.endIndex.predecessor()] == 0)
		var	r	=	nil as NSData?
		cCharacters.withUnsafeBufferPointer { (p:UnsafeBufferPointer<CChar>) -> () in
			let	p1	=	UnsafePointer<Void>(p.baseAddress)
			r		=	NSData(bytes: p1, length: p.count)
		}
		return	r!
	}
}