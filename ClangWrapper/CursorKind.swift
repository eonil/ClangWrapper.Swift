//
//  CursorKind.swift
//  libclang_example1
//
//  Created by Hoon H. on 2015/01/21.
//  Copyright (c) 2015 Eonil. All rights reserved.
//

import Foundation


public enum CursorKind: UInt32 {
	/* Declarations */
	/**
	* \brief A declaration whose specific kind is not exposed via this
	* interface.
	*
	* Unexposed declarations have the same operations as any other kind
	* of declaration; one can extract their location information,
	* spelling, find their definitions, etc. However, the specific kind
	* of the declaration is not reported.
	*/
	case UnexposedDecl                 = 1
	/** \brief A C or C++ struct. */
	case StructDecl                    = 2
	/** \brief A C or C++ union. */
	case UnionDecl                     = 3
	/** \brief A C++ class. */
	case ClassDecl                     = 4
	/** \brief An enumeration. */
	case EnumDecl                      = 5
	/**
	* \brief A field (in C) or non-static data member (in C++) in a
	* struct, union, or C++ class.
	*/
	case FieldDecl                     = 6
	/** \brief An enumerator constant. */
	case EnumConstantDecl              = 7
	/** \brief A function. */
	case FunctionDecl                  = 8
	/** \brief A variable. */
	case VarDecl                       = 9
	/** \brief A function or method parameter. */
	case ParmDecl                      = 10
	/** \brief An Objective-C \@interface. */
	case ObjCInterfaceDecl             = 11
	/** \brief An Objective-C \@interface for a category. */
	case ObjCCategoryDecl              = 12
	/** \brief An Objective-C \@protocol declaration. */
	case ObjCProtocolDecl              = 13
	/** \brief An Objective-C \@property declaration. */
	case ObjCPropertyDecl              = 14
	/** \brief An Objective-C instance variable. */
	case ObjCIvarDecl                  = 15
	/** \brief An Objective-C instance method. */
	case ObjCInstanceMethodDecl        = 16
	/** \brief An Objective-C class method. */
	case ObjCClassMethodDecl           = 17
	/** \brief An Objective-C \@implementation. */
	case ObjCImplementationDecl        = 18
	/** \brief An Objective-C \@implementation for a category. */
	case ObjCCategoryImplDecl          = 19
	/** \brief A typedef */
	case TypedefDecl                   = 20
	/** \brief A C++ class method. */
	case CXXMethod                     = 21
	/** \brief A C++ namespace. */
	case Namespace                     = 22
	/** \brief A linkage specification, e.g. 'extern "C"'. */
	case LinkageSpec                   = 23
	/** \brief A C++ constructor. */
	case Constructor                   = 24
	/** \brief A C++ destructor. */
	case Destructor                    = 25
	/** \brief A C++ conversion function. */
	case ConversionFunction            = 26
	/** \brief A C++ template type parameter. */
	case TemplateTypeParameter         = 27
	/** \brief A C++ non-type template parameter. */
	case NonTypeTemplateParameter      = 28
	/** \brief A C++ template template parameter. */
	case TemplateTemplateParameter     = 29
	/** \brief A C++ function template. */
	case FunctionTemplate              = 30
	/** \brief A C++ class template. */
	case ClassTemplate                 = 31
	/** \brief A C++ class template partial specialization. */
	case ClassTemplatePartialSpecialization = 32
	/** \brief A C++ namespace alias declaration. */
	case NamespaceAlias                = 33
	/** \brief A C++ using directive. */
	case UsingDirective                = 34
	/** \brief A C++ using declaration. */
	case UsingDeclaration              = 35
	/** \brief A C++ alias declaration */
	case TypeAliasDecl                 = 36
	/** \brief An Objective-C \@synthesize definition. */
	case ObjCSynthesizeDecl            = 37
	/** \brief An Objective-C \@dynamic definition. */
	case ObjCDynamicDecl               = 38
	/** \brief An access specifier. */
	case CXXAccessSpecifier            = 39
	
//	case FirstDecl                     = CXCursor_UnexposedDecl,
//	case LastDecl                      = CXCursor_CXXAccessSpecifier,
	
	/* References */
	case FirstRef                      = 40  /* Decl references */
//	case ObjCSuperClassRef             = 40
	case ObjCProtocolRef               = 41
	case ObjCClassRef                  = 42
	/**
	* \brief A reference to a type declaration.
	*
	* A type reference occurs anywhere where a type is named but not
	* declared. For example, given:
	*
	* \code
	* typedef unsigned size_type;
	* size_type size;
	* \endcode
	*
	* The typedef is a declaration of size_type (CXCursor_TypedefDecl),
	* while the type of the variable "size" is referenced. The cursor
	* referenced by the type of size is the typedef for size_type.
	*/
	case TypeRef                       = 43
	case CXXBaseSpecifier              = 44
	/**
	* \brief A reference to a class template, function template, template
	* template parameter, or class template partial specialization.
	*/
	case TemplateRef                   = 45
	/**
	* \brief A reference to a namespace or namespace alias.
	*/
	case NamespaceRef                  = 46
	/**
	* \brief A reference to a member of a struct, union, or class that occurs in
	* some non-expression context, e.g., a designated initializer.
	*/
	case MemberRef                     = 47
	/**
	* \brief A reference to a labeled statement.
	*
	* This cursor kind is used to describe the jump to "start_over" in the
	* goto statement in the following example:
	*
	* \code
	*   start_over:
	*     ++counter;
	*
	*     goto start_over;
	* \endcode
	*
	* A label reference cursor refers to a label statement.
	*/
	case LabelRef                      = 48
	
	/**
	* \brief A reference to a set of overloaded functions or function templates
	* that has not yet been resolved to a specific function or function template.
	*
	* An overloaded declaration reference cursor occurs in C++ templates where
	* a dependent name refers to a function. For example:
	*
	* \code
	* template<typename T> void swap(T&, T&);
	*
	* struct X { ... };
	* void swap(X&, X&);
	*
	* template<typename T>
	* void reverse(T* first, T* last) {
	*   while (first < last - 1) {
	*     swap(*first, *--last);
	*     ++first;
	*   }
	* }
	*
	* struct Y { };
	* void swap(Y&, Y&);
	* \endcode
	*
	* Here, the identifier "swap" is associated with an overloaded declaration
	* reference. In the template definition, "swap" refers to either of the two
	* "swap" functions declared above, so both results will be available. At
	* instantiation time, "swap" may also refer to other functions found via
	* argument-dependent lookup (e.g., the "swap" function at the end of the
	* example).
	*
	* The functions \c clang_getNumOverloadedDecls() and
	* \c clang_getOverloadedDecl() can be used to retrieve the definitions
	* referenced by this cursor.
	*/
	case OverloadedDeclRef             = 49
	
	/**
	* \brief A reference to a variable that occurs in some non-expression
	* context, e.g., a C++ lambda capture list.
	*/
	case VariableRef                   = 50
	
//	case LastRef                       = CXCursor_VariableRef,
	
	/* Error conditions */
	case FirstInvalid                  = 70
//	case InvalidFile                   = 70
	case NoDeclFound                   = 71
	case NotImplemented                = 72
	case InvalidCode                   = 73
//	case LastInvalid                   = CXCursor_InvalidCode,
	
	/* Expressions */
	case FirstExpr                     = 100
	
	/**
	* \brief An expression whose specific kind is not exposed via this
	* interface.
	*
	* Unexposed expressions have the same operations as any other kind
	* of expression; one can extract their location information,
	* spelling, children, etc. However, the specific kind of the
	* expression is not reported.
	*/
//	case UnexposedExpr                 = 100
	
	/**
	* \brief An expression that refers to some value declaration, such
	* as a function, variable, or enumerator.
	*/
	case DeclRefExpr                   = 101
	
	/**
	* \brief An expression that refers to a member of a struct, union,
	* class, Objective-C class, etc.
	*/
	case MemberRefExpr                 = 102
	
	/** \brief An expression that calls a function. */
	case CallExpr                      = 103
	
	/** \brief An expression that sends a message to an Objective-C
	object or class. */
	case ObjCMessageExpr               = 104
	
	/** \brief An expression that represents a block literal. */
	case BlockExpr                     = 105
	
	/** \brief An integer literal.
	*/
	case IntegerLiteral                = 106
	
	/** \brief A floating point number literal.
	*/
	case FloatingLiteral               = 107
	
	/** \brief An imaginary number literal.
	*/
	case ImaginaryLiteral              = 108
	
	/** \brief A string literal.
	*/
	case StringLiteral                 = 109
	
	/** \brief A character literal.
	*/
	case CharacterLiteral              = 110
	
	/** \brief A parenthesized expression, e.g. "(1)".
	*
	* This AST node is only formed if full location information is requested.
	*/
	case ParenExpr                     = 111
	
	/** \brief This represents the unary-expression's (except sizeof and
	* alignof).
	*/
	case UnaryOperator                 = 112
	
	/** \brief [C99 6.5.2.1] Array Subscripting.
	*/
	case ArraySubscriptExpr            = 113
	
	/** \brief A builtin binary operation expression such as "x + y" or
	* "x <= y".
	*/
	case BinaryOperator                = 114
	
	/** \brief Compound assignment such as "+=".
	*/
	case CompoundAssignOperator        = 115
	
	/** \brief The ?: ternary operator.
	*/
	case ConditionalOperator           = 116
	
	/** \brief An explicit cast in C (C99 6.5.4) or a C-style cast in C++
	* (C++ [expr.cast]), which uses the syntax (Type)expr.
	*
	* For example: (int)f.
	*/
	case CStyleCastExpr                = 117
	
	/** \brief [C99 6.5.2.5]
	*/
	case CompoundLiteralExpr           = 118
	
	/** \brief Describes an C or C++ initializer list.
	*/
	case InitListExpr                  = 119
	
	/** \brief The GNU address of label extension, representing &&label.
	*/
	case AddrLabelExpr                 = 120
	
	/** \brief This is the GNU Statement Expression extension: ({int X=4; X;})
	*/
	case StmtExpr                      = 121
	
	/** \brief Represents a C11 generic selection.
	*/
	case GenericSelectionExpr          = 122
	
	/** \brief Implements the GNU __null extension, which is a name for a null
	* pointer constant that has integral type (e.g., int or long) and is the same
	* size and alignment as a pointer.
	*
	* The __null extension is typically only used by system headers, which define
	* NULL as __null in C++ rather than using 0 (which is an integer that may not
	* match the size of a pointer).
	*/
	case GNUNullExpr                   = 123
	
	/** \brief C++'s static_cast<> expression.
	*/
	case CXXStaticCastExpr             = 124
	
	/** \brief C++'s dynamic_cast<> expression.
	*/
	case CXXDynamicCastExpr            = 125
	
	/** \brief C++'s reinterpret_cast<> expression.
	*/
	case CXXReinterpretCastExpr        = 126
	
	/** \brief C++'s const_cast<> expression.
	*/
	case CXXConstCastExpr              = 127
	
	/** \brief Represents an explicit C++ type conversion that uses "functional"
	* notion (C++ [expr.type.conv]).
	*
	* Example:
	* \code
	*   x = int(0.5);
	* \endcode
	*/
	case CXXFunctionalCastExpr         = 128
	
	/** \brief A C++ typeid expression (C++ [expr.typeid]).
	*/
	case CXXTypeidExpr                 = 129
	
	/** \brief [C++ 2.13.5] C++ Boolean Literal.
	*/
	case CXXBoolLiteralExpr            = 130
	
	/** \brief [C++0x 2.14.7] C++ Pointer Literal.
	*/
	case CXXNullPtrLiteralExpr         = 131
	
	/** \brief Represents the "this" expression in C++
	*/
	case CXXThisExpr                   = 132
	
	/** \brief [C++ 15] C++ Throw Expression.
	*
	* This handles 'throw' and 'throw' assignment-expression. When
	* assignment-expression isn't present, Op will be null.
	*/
	case CXXThrowExpr                  = 133
	
	/** \brief A new expression for memory allocation and constructor calls, e.g:
	* "new CXXNewExpr(foo)".
	*/
	case CXXNewExpr                    = 134
	
	/** \brief A delete expression for memory deallocation and destructor calls,
	* e.g. "delete[] pArray".
	*/
	case CXXDeleteExpr                 = 135
	
	/** \brief A unary expression.
	*/
	case UnaryExpr                     = 136
	
	/** \brief An Objective-C string literal i.e. @"foo".
	*/
	case ObjCStringLiteral             = 137
	
	/** \brief An Objective-C \@encode expression.
	*/
	case ObjCEncodeExpr                = 138
	
	/** \brief An Objective-C \@selector expression.
	*/
	case ObjCSelectorExpr              = 139
	
	/** \brief An Objective-C \@protocol expression.
	*/
	case ObjCProtocolExpr              = 140
	
	/** \brief An Objective-C "bridged" cast expression, which casts between
	* Objective-C pointers and C pointers, transferring ownership in the process.
	*
	* \code
	*   NSString *str = (__bridge_transfer NSString *)CFCreateString();
	* \endcode
	*/
	case ObjCBridgedCastExpr           = 141
	
	/** \brief Represents a C++0x pack expansion that produces a sequence of
	* expressions.
	*
	* A pack expansion expression contains a pattern (which itself is an
	* expression) followed by an ellipsis. For example:
	*
	* \code
	* template<typename F, typename ...Types>
	* void forward(F f, Types &&...args) {
	*  f(static_cast<Types&&>(args)...);
	* }
	* \endcode
	*/
	case PackExpansionExpr             = 142
	
	/** \brief Represents an expression that computes the length of a parameter
	* pack.
	*
	* \code
	* template<typename ...Types>
	* struct count {
	*   static const unsigned value = sizeof...(Types);
	* };
	* \endcode
	*/
	case SizeOfPackExpr                = 143
	
	/* \brief Represents a C++ lambda expression that produces a local function
	* object.
	*
	* \code
	* void abssort(float *x, unsigned N) {
	*   std::sort(x, x + N,
	*             [](float a, float b) {
	*               return std::abs(a) < std::abs(b);
	*             });
	* }
	* \endcode
	*/
	case LambdaExpr                    = 144
	
	/** \brief Objective-c Boolean Literal.
	*/
	case ObjCBoolLiteralExpr           = 145
	
	/** \brief Represents the "self" expression in an Objective-C method.
	*/
	case ObjCSelfExpr                  = 146
	
//	case LastExpr                      = CXCursor_ObjCSelfExpr,
	
	/* Statements */
	case FirstStmt                     = 200
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
	
	/** \brief A labelled statement in a function.
	*
	* This cursor kind is used to describe the "start_over:" label statement in
	* the following example:
	*
	* \code
	*   start_over:
	*     ++counter;
	* \endcode
	*
	*/
	case LabelStmt                     = 201
	
	/** \brief A group of statements like { stmt stmt }.
	*
	* This cursor kind is used to describe compound statements, e.g. function
	* bodies.
	*/
	case CompoundStmt                  = 202
	
	/** \brief A case statement.
	*/
	case CaseStmt                      = 203
	
	/** \brief A default statement.
	*/
	case DefaultStmt                   = 204
	
	/** \brief An if statement
	*/
	case IfStmt                        = 205
	
	/** \brief A switch statement.
	*/
	case SwitchStmt                    = 206
	
	/** \brief A while statement.
	*/
	case WhileStmt                     = 207
	
	/** \brief A do statement.
	*/
	case DoStmt                        = 208
	
	/** \brief A for statement.
	*/
	case ForStmt                       = 209
	
	/** \brief A goto statement.
	*/
	case GotoStmt                      = 210
	
	/** \brief An indirect goto statement.
	*/
	case IndirectGotoStmt              = 211
	
	/** \brief A continue statement.
	*/
	case ContinueStmt                  = 212
	
	/** \brief A break statement.
	*/
	case BreakStmt                     = 213
	
	/** \brief A return statement.
	*/
	case ReturnStmt                    = 214
	
	/** \brief A GCC inline assembly statement extension.
	*/
	case GCCAsmStmt                    = 215
//	case AsmStmt                       = CXCursor_GCCAsmStmt,
	
	/** \brief Objective-C's overall \@try-\@catch-\@finally statement.
	*/
	case ObjCAtTryStmt                 = 216
	
	/** \brief Objective-C's \@catch statement.
	*/
	case ObjCAtCatchStmt               = 217
	
	/** \brief Objective-C's \@finally statement.
	*/
	case ObjCAtFinallyStmt             = 218
	
	/** \brief Objective-C's \@throw statement.
	*/
	case ObjCAtThrowStmt               = 219
	
	/** \brief Objective-C's \@synchronized statement.
	*/
	case ObjCAtSynchronizedStmt        = 220
	
	/** \brief Objective-C's autorelease pool statement.
	*/
	case ObjCAutoreleasePoolStmt       = 221
	
	/** \brief Objective-C's collection statement.
	*/
	case ObjCForCollectionStmt         = 222
	
	/** \brief C++'s catch statement.
	*/
	case CXXCatchStmt                  = 223
	
	/** \brief C++'s try statement.
	*/
	case CXXTryStmt                    = 224
	
	/** \brief C++'s for (* : *) statement.
	*/
	case CXXForRangeStmt               = 225
	
	/** \brief Windows Structured Exception Handling's try statement.
	*/
	case SEHTryStmt                    = 226
	
	/** \brief Windows Structured Exception Handling's except statement.
	*/
	case SEHExceptStmt                 = 227
	
	/** \brief Windows Structured Exception Handling's finally statement.
	*/
	case SEHFinallyStmt                = 228
	
	/** \brief A MS inline assembly statement extension.
	*/
	case MSAsmStmt                     = 229
	
	/** \brief The null statement ";": C99 6.8.3p3.
	*
	* This cursor kind is used to describe the null statement.
	*/
	case NullStmt                      = 230
	
	/** \brief Adaptor class for mixing declarations with statements and
	* expressions.
	*/
	case DeclStmt                      = 231
	
	/** \brief OpenMP parallel directive.
	*/
	case OMPParallelDirective          = 232
	
	/** \brief OpenMP SIMD directive.
	*/
	case OMPSimdDirective              = 233
	
	/** \brief OpenMP for directive.
	*/
	case OMPForDirective               = 234
	
	/** \brief OpenMP sections directive.
	*/
	case OMPSectionsDirective          = 235
	
	/** \brief OpenMP section directive.
	*/
	case OMPSectionDirective           = 236
	
	/** \brief OpenMP single directive.
	*/
	case OMPSingleDirective            = 237
	
	/** \brief OpenMP parallel for directive.
	*/
	case OMPParallelForDirective       = 238
	
	/** \brief OpenMP parallel sections directive.
	*/
	case OMPParallelSectionsDirective  = 239
	
	/** \brief OpenMP task directive.
	*/
	case OMPTaskDirective              = 240
	
	/** \brief OpenMP master directive.
	*/
	case OMPMasterDirective            = 241
	
	/** \brief OpenMP critical directive.
	*/
	case OMPCriticalDirective          = 242
	
	/** \brief OpenMP taskyield directive.
	*/
	case OMPTaskyieldDirective         = 243
	
	/** \brief OpenMP barrier directive.
	*/
	case OMPBarrierDirective           = 244
	
	/** \brief OpenMP taskwait directive.
	*/
	case OMPTaskwaitDirective          = 245
	
	/** \brief OpenMP flush directive.
	*/
	case OMPFlushDirective             = 246
	
	/** \brief Windows Structured Exception Handling's leave statement.
	*/
	case SEHLeaveStmt                  = 247
	
	/** \brief OpenMP ordered directive.
	*/
	case OMPOrderedDirective           = 248
	
	/** \brief OpenMP atomic directive.
	*/
	case OMPAtomicDirective            = 249
	
	/** \brief OpenMP for SIMD directive.
	*/
	case OMPForSimdDirective           = 250
	
	/** \brief OpenMP parallel for SIMD directive.
	*/
	case OMPParallelForSimdDirective   = 251
	
	/** \brief OpenMP target directive.
	*/
	case OMPTargetDirective            = 252
	
	/** \brief OpenMP teams directive.
	*/
	case OMPTeamsDirective             = 253
	
//	case LastStmt                      = CXCursor_OMPTeamsDirective,
	
	/**
	* \brief Cursor that represents the translation unit itself.
	*
	* The translation unit cursor exists primarily to act as the root
	* cursor for traversing the contents of a translation unit.
	*/
	case TranslationUnit               = 300
	
	/* Attributes */
	case FirstAttr                     = 400
//	/**
//	* \brief An attribute whose specific kind is not exposed via this
//	* interface.
//	*/
//	case UnexposedAttr                 = 400
	
	case IBActionAttr                  = 401
	case IBOutletAttr                  = 402
	case IBOutletCollectionAttr        = 403
	case CXXFinalAttr                  = 404
	case CXXOverrideAttr               = 405
	case AnnotateAttr                  = 406
	case AsmLabelAttr                  = 407
	case PackedAttr                    = 408
	case PureAttr                      = 409
	case ConstAttr                     = 410
	case NoDuplicateAttr               = 411
	case CUDAConstantAttr              = 412
	case CUDADeviceAttr                = 413
	case CUDAGlobalAttr                = 414
	case CUDAHostAttr                  = 415
	case CUDASharedAttr                = 416
//	case LastAttr                      = CXCursor_CUDASharedAttr,
	
	/* Preprocessing */
	case PreprocessingDirective        = 500
	case MacroDefinition               = 501
	case MacroExpansion                = 502
//	case MacroInstantiation            = CXCursor_MacroExpansion,
	case InclusionDirective            = 503
//	case FirstPreprocessing            = CXCursor_PreprocessingDirective,
//	case LastPreprocessing             = CXCursor_InclusionDirective,
	
	/* Extra Declarations */
	/**
	* \brief A module import declaration.
	*/
	case ModuleImportDecl              = 600
//	case FirstExtraDecl                = CXCursor_ModuleImportDecl,
//	case LastExtraDecl                 = CXCursor_ModuleImportDecl
}


