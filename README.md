# fe

> Haitian Creole for `make`.

## Installation

- With `haxelib` git.

```
haxelib git klas https://github.com/skial/fe master src
```

- With haxelib local.

```
# Download the archive.
https://github.com/skial/fe/archive/master.zip

# Install archive contents.
haxelib local master.zip
```

## Usage

Supported syntax:

- Create fragments with `name`, which turns into `<name></name>`.
- Add classes `name.class1.classN`, which turns into `<name class="class1 classN"></name>`.
- Add attributes `name[id=Haxe]`, which turns into `<name id="Haxe"></name>`.
	+ Unfortuantly, multiple attributes are set with `name[a=1][b=2][c=3]`.
- Add children to an element with `name > child`, which turns into `<name><child></child></name>`.
- Add siblings to an element with `name + sibling`, which turns into `<name></name><sibling></sibling>`.
- Separate elements into groups with parentheses, `html > (head > meta[charset=utf-8]) + (body > article)` .

```
class Main {
	
	public static function main() {
		trace( html(button.important.large[type=submit]) );
	}
	
}
```
