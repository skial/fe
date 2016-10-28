package uhx.fe;

import uhx.lexer.Html;
import haxe.macro.Expr;
import haxe.ds.StringMap;
import haxe.macro.Context;

using uhx.lexer.Html;
using haxe.macro.ExprTools;

private typedef Token = uhx.mo.Token<HtmlKeywords>;
private typedef Tokens = Array<Token>;

@:access(uhx.lexer.Html)
class Html {
	
	public static macro function html(expr:Expr):Expr {
		var t = transform(expr);
		trace( t );
		return macro $v{new uhx.parser.Html().print( t ).toString()};
	}
	
	public static function transform(expr:Expr, ?last:Null<Array<Token>>):Array<Token> {
		var results = switch expr {
			case macro $e1 > $e2:
				var tags = transform( e1, transform( e2, last ) );
				
				tags;
				
			case macro $e1 + $e2:
				var child = transform( e1 );
				var sibling = transform( e2, last );
				
				var children = [];
				for (x in child) children.push( x );
				for (x in sibling) children.push( x );
				
				children;
				
			case _.expr => EConst(CIdent(name)):
				var parent = new HtmlRef( 
					name, 
					new StringMap(), 
					name.categories(), 
					(last == null ? [] : last), 
					function() return null,
					false, 
					name.model() == Model.Empty 
				);
				
				if (last != null) for (token in last) {
					switch token {
						case Keyword(Tag( ref )):
							ref.parent = function() return Keyword(Tag( parent ));
							
						case _:
							
					}
					
				}
				
				[Keyword(Tag( parent ))];
				
			case _.expr => EField(e, name):
				var tags = transform( e, last );
				
				switch tags[tags.length - 1] {
					case Keyword(Tag( tag )):
						if (!tag.attributes.exists('class')) {
							tag.attributes.set( 'class', name );
						} else {
							tag.attributes.set( 'class', tag.attributes.get( 'class' ) + ' $name' );
						}
						
					case _:
						throw 'Current element was not expected while attempting to add attributes.';
						
				}
				
				tags;
				
			case _.expr => EArray(e, attr):
				var tags = transform( e, last );
				addAttributes( tags[tags.length - 1], attr );
				tags;
				
			case _.expr => EConst(CString(value)):
				[Keyword(Text( new Ref(value) ))];
				
			case _:
				throw expr;
				
		}
		
		return results;
	}
	
	public static function addAttributes(element:Token, expr:Expr):Void {
		switch expr {
			case macro $e1 = $e2:
				switch element {
					case Keyword(Tag( tag )):
						tag.attributes.set( print( e1 ), print( e2 ) );
						
					case _:
						throw 'Current element was not expected while attempting to add attributes.';
						
				}
				
			case _:
				throw expr;
				
		}
	}
	
	public static function print(expr:Expr):String {
		return switch expr {
			case _.expr => EConst(CIdent(name)): name;
			case _.expr => EConst(CString(value)): value;
			case _.expr => EConst(CInt(value)): value;
			case _.expr => EConst(CFloat(value)): value;
			case macro $e1-$e2: print(e1) + '-' + print(e2);
			case _: throw expr;
		}
	}
	
}
