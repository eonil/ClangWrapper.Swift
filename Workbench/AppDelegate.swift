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
		let	path		=	NSBundle.mainBundle().pathForResource("Sample", ofType: "c")!
		
		let	idx			=	Index(excludeDeclarationsFromPCH: false, displayDiagnostics: false)
		let	transunit	=	idx.parseTranslationUnit(path)
		
		transunit.diagnostics.map { (d:Diagnostic)->() in
			println(d.spelling)
		}

		println(transunit.cursor.description)
	}

	func applicationWillTerminate(aNotification: NSNotification) {
		// Insert code here to tear down your application
	}


}


//func runOverChildrenOf(c:Cursor, depth:Int) {
//	c.visitChildrenWithBlock { (cursor, parent) -> ChildVisitResult in
//		let	indent	=	join("", Repeat(count: depth, repeatedValue: "  "))
//		println("\(indent)[\(cursor.spelling)] -> \(cursor.kind)")
//		runOverChildrenOf(cursor, depth+1)
//		return	ChildVisitResult.Continue
//	}
//}








