# fe

> Haitian Creole for `make`.

## Installation

With haxelib git.

```
haxelib git klas https://github.com/skial/fe master src
```

With haxelib local.

```
# Download the archive.
https://github.com/skial/fe/archive/master.zip

# Install archive contents.
haxelib local master.zip
```

## Usage

### Supported syntax:

Haxe Syntax | Html Result
------------ | -------------
`div` | `<div></div>`
`meta` | `<meta />`
`div.class1.classN` | `<div class="class1 classN"></div>`
`div[id=Haxe]` | `<div> id="Haxe"></div>`
`button[type=submit]` | `<button type="submit"></button>`
`link[rel="stylesheet"][href="/css/normalize.css"]` | `<link rel="stylesheet" href="/css/normalize.css" />`
`html > body` | `<html><body></body></html>`
`head + body` | `<head></head><body></body>`
`html > (head > meta[charset=utf-8]) + (body > p > "Hello World")` | ```
<html>
	<head>
		<meta charset="utf-8" />
	</head>`
	<body>
		<p>
			Hello World
		</p>
	</body>
</html>
```

### Example

```Haxe
import uhx.fe.Html.*;

class Main {
	
	public static function main() {
		trace( html(button.important.large[type=submit]) ); // <button class="important large" type="submit"></button>
	}
	
}
```
