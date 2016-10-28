package uhx.fe;

import utest.Assert;
import uhx.fe.Html.*;

class HtmlSpec {
	
	public function new() {
		
	}
	
	public function testIdent() {
		var value = html(button);
		Assert.equals( '<button></button>', value );
	}
	
	public function testChild() {
		var value = html(button > 'Submit');
		Assert.equals( '<button>\n\tSubmit\n</button>', value );
	}
	
	public function testMultipleChildren() {
		var value = html(html > body > article > section > div > p > 'deep');
		// Ahhhh
		Assert.equals( 
			'<html>\n\t<body>\n\t\t<article>\n\t\t\t<section>\n\t\t\t\t<div>\n\t\t\t\t\t<p>\n\t\t\t\t\t\tdeep\n\t\t\t\t\t</p>\n\t\t\t\t</div>\n\t\t\t</section>\n\t\t</article>\n\t</body>\n</html>',
			value
		);
	}
	
	public function testClassAttribute() {
		var value = html(button.large);
		Assert.equals( '<button class="large"></button>', value );
	}
	
	public function testMultipleClassAttribute() {
		var value = html(button.large.important.red);
		Assert.equals( '<button class="large important red"></button>', value );
	}
	
	public function testAttribute() {
		var value = html(button[type=submit]);
		Assert.equals( '<button type="submit"></button>', value );
	}
	
	public function testMultipleAttributes() {
		// TODO Figure out suitable syntax for multiple values in single assignment.
		var value = html(button[type=submit][name="Test Runner"][autofocus=false]);
		// TODO detect boolean values correctly, as they get wrapped as strings.
		Assert.stringContains( 'type="submit"', value );
		Assert.stringContains( 'name="Test Runner"', value );
		Assert.stringContains( 'autofocus="false"', value );
	}
	
	public function testSelfClosing_Meta() {
		var value = html(meta[name="twitter:creator"][content="@skial"]);
		Assert.equals( '<meta name="twitter:creator" content="@skial" />', value );
	}
	
	public function testSelfClosing_Link() {
		var value = html(link[rel="stylesheet"][href="/css/normalize.css"]);
		Assert.equals( '<link rel="stylesheet" href="/css/normalize.css" />', value );
	}
	
	public function testSibling() {
		var value = html(html > head + body);
		Assert.equals( '<html>\n\t<head></head>\n\t<body></body>\n</html>', value );
	}
	
}
