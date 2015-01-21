//
//  AppDelegate.swift
//  Workbench
//
//  Created by Hoon H. on 2015/01/21.
//  Copyright (c) 2015 Eonil. All rights reserved.
//

import Cocoa
import ClangWrapper

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

	@IBOutlet weak var window: NSWindow!


	func applicationDidFinishLaunching(aNotification: NSNotification) {
		func run(f:()->()) {
			f()
		}
		
//		run {
//			let	path		=	NSBundle.mainBundle().pathForResource("Sample", ofType: "c")!
//			
//			let	idx			=	Index(excludeDeclarationsFromPCH: false, displayDiagnostics: false)
//			let	transunit	=	idx.parseTranslationUnit(path)
//			
//			transunit.diagnostics.map { (d:Diagnostic)->() in
//				println(d.spelling)
//			}
//			
//			println(transunit)
//		}
//		
//		run {
//			let	path		=	NSBundle.mainBundle().pathForResource("Sample2", ofType: "h")!
//			
//			let	idx			=	Index(excludeDeclarationsFromPCH: false, displayDiagnostics: false)
//			let	transunit	=	idx.parseTranslationUnit(path, commandLineArguments: ["-std=c++11"])
//			
//			transunit.diagnostics.map { (d:Diagnostic)->() in
//				println(d.spelling)
//			}
//			
//			println(transunit)
//		}
		
		
		run {
			let	path		=	NSBundle.mainBundle().pathForResource("Sample2", ofType: "h")!
			
			let	idx			=	Index(excludeDeclarationsFromPCH: false, displayDiagnostics: false)
			let	transunit	=	idx.parseTranslationUnit(path, commandLineArguments: ["-std=c++11"])
			
			let	c			=	transunit.cursor
			
			struct Util {
				static func query(c:Cursor, depth:Int) {
					let	indent	=	join("", Repeat(count: depth, repeatedValue: "  "))
					let	extra	=	c.spelling == "" ? " " + c.sourceCode : ""
					println("\(indent)\(c.kind) [\(c.spelling)]\(extra)")

					for c1 in c.children {
						Util.query(c1, depth: depth+1)
					}
				}
			}
			
			Util.query(c, depth: 0)
		}
	}

	func applicationWillTerminate(aNotification: NSNotification) {
		// Insert code here to tear down your application
	}


}





extension Cursor {
	var sourceCode:String {
		get {
			return	stringOfRange(translationUnit, extent)
		}
	}
}

func stringOfRange(unit:TranslationUnit, range:SourceRange) -> String {
	var	a		=	[] as [String]
	let	tkseq	=	unit.tokenize(range)
	for tk in tkseq {
		a.append(tk.spelling)
	}
	return	join(" ", a)
}





