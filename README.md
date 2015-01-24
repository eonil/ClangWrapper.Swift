Eonil/ClangWrapper
===================
2015/01/21
Hoon H.




Provides a set of wrapper classes around `libclang` library API. (C API, not C++ API)






How to Use
----------
Here's a quick example. (a part of `Workbench` example)

	let	path		=	NSBundle.mainBundle().pathForResource("Sample", ofType: "c")!

	let	idx			=	Index(excludeDeclarationsFromPCH: false, displayDiagnostics: false)
	let	transunit	=	idx.parseTranslationUnit(path)

	transunit.diagnostics.map { (d:Diagnostic)->() in
	println(d.spelling)
	}

	println(transunit)

Above code should print something like this.

	implicitly declaring library function 'printf' with type 'int (const char *, ...)'
	main (FunctionDecl, 1:1~11:1)
	   (CompoundStmt, 4:1~7:2)
		printf (CallExpr, 4:12~7:2)
		  printf (FirstExpr/UnexposedExpr, 5:2~5:32)
			printf (DeclRefExpr, 5:2~5:8)
		   (FirstExpr/UnexposedExpr, 5:2~5:32)
			 (FirstExpr/UnexposedExpr, 5:9~5:15)
			  "%s\n" (StringLiteral, 5:9~5:15)
		   (FirstExpr/UnexposedExpr, 5:2~5:32)
			"Hello world!" (StringLiteral, 5:17~5:31)
		 (ReturnStmt, 4:12~7:2)
		   (IntegerLiteral, 6:2~6:10)


Some points.

-	The starting point is `Index` class.
-	Only fundamental feature are in the classes. Extension features are in extensions.
-	There's [an awesome overview about C API by "Mike Ash"](https://www.mikeash.com/pyblog/friday-qa-2014-01-24-introduction-to-libclang.html).
	As this wrapper models C API as is, the text should help a lot.
-	Also you must see this slide. ["libclang: Thinking Beyond the Compiler" Doug Gregor, Apple Inc.](http://llvm.org/devmtg/2010-11/Gregor-libclang.pdf)


If you want to force specific language mode, use this method.

	let	transunit	=	idx.parseTranslationUnit(path, commandLineArguments: ["-std=c++11"])













Caveats
-------
-	This framework is designed for Swift.

-	This framework links to `libclang.dylib` included in Xcode.

		$(DEVELOPER_DIR)/Toolchains/XcodeDefault.xctoolchain/usr/lib

	That will be resolved to 

		/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/libclang.dylib

	Ths library path is hardcoded in `LD_RUNPATH_SEARCH_PATHS`. Change this if you want
	to use your own binary.

-	This framework is using Clang's C API that is intended to be stable.
	Linking to Xcode bonary should be fine.

-	This framework does not fully cover C API (yet).




Design Choices
--------------
-	All strings are passed by copy. Performance can be decreased.
-	An extra method like `stringBuffer` can be added later for efficiency.
-	`Index` class serves as local proxy root container. It manages all the proxy objects connected over C API.
	You have to keep a reference to `Index` object to keep any of its object.
-	Uses C-like tree (unique-ownership) manual resource management. That means you need to call `dispose` 
	manually on them to free up allocated resources. If an object does not support `dispose`, it means it does 
	not allocate resources internally.
-	For your safety and convenience, all proxy objects will be tracked and `dispose`d when `Index` deinitializes
	if it has not been disposed. 
-	Enums constant values are copied from `libclang` headers if they're explicitly defined.





References
----------

-	[Awesome introduction to `libclang` C API by Mike Ash](https://www.mikeash.com/pyblog/friday-qa-2014-01-24-introduction-to-libclang.html).
-	[Even better introduction to `libclang` C API by Doug Gregor](http://llvm.org/devmtg/2010-11/Gregor-libclang.pdf)











License
-------
Portion of my work is licensed under "MIT license".
This project contains some header files from LLVM project. That is licensed under "University of Illinois/NCSA Open Source License".
The portion of LLVM project is all header files in `/ClangWrapper/include` directory.
The product of this project will be linked to a component of Xcode. That is a intellectual property of Apple. You can avoid this by 
changing link parameters. I don't redistribute any code from Xcode, so I believe this linking is fine. But please let me know if 
something is wrong.






