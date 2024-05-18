---

theme: gaia
_class: lead
paginate: false
backgroundColor: #fff
backgroundImage: url('https://marp.app/assets/hero-background.svg')
marp: true

---

# **Katastro![height:50px](https://www.php.net//images/logos/new-php-logo.svg)al**
the worst of PHP

---

# Wer bin ich?

![bg right:30% 70% saturate:70%](https://avatars.githubusercontent.com/u/36010519?v=4)
Niklas Schmidt _(er/ihn)_

![height:25px](https://www.php.net//images/logos/php-logo.svg)-Developer bei ![height:30px](https://avatars.githubusercontent.com/u/11328598?s=200&v=4) traperto

<br>

![height:30px](https://upload.wikimedia.org/wikipedia/commons/9/91/Octicons-mark-github.svg)/_neon-js_

---

# TODOs
- Callables _(oder: Wie ich lernte, Arrays zu lieben)_
- Callables 2 - _Noch Älter. Härter. Besser._
- variable Variablen
- Footguns
  - Backticks
  - 🔥 Spicy Regexes 🔥
  - Zahlen
- Standard Library aus der Hölle
- Warum gibt es diese Funktionen?

---

# Callables 
_(oder: Wie ich lernte, Arrays zu lieben)_

- Typ `callable` kam erst mit PHP 5.4

---

# Callables

- Typ `callable` kam erst mit PHP 5.4
-  `array_filter($array, $callback)` kam schon mit PHP 4.0.6

---

# Callables

- Typ `callable` kam erst mit PHP 5.4
-  `array_filter($array, $callback)` kam schon mit PHP 4.0.6
- 5.4 > 4.0.6 ???

---

# Callables

- Typ `callable` kam erst mit PHP 5.4
-  `array_filter($array, $callback)` kam schon mit PHP 4.0.6
- 5.4 > 4.0.6 ???
- **Arrays verwenden!** (was auch sonst?)

---

# Callables

- Typ `callable` kam erst mit PHP 5.4
-  `array_filter($array, $callback)` kam schon mit PHP 4.0.6
- 5.4 > 4.0.6 ???
- **Arrays verwenden!** (was auch sonst?)

- `[$object, $methodName]` is ein gültiges `callable`

---

# Callables

- Typ `callable` kam erst mit PHP 5.4
-  `array_filter($array, $callback)` kam schon mit PHP 4.0.6
- 5.4 > 4.0.6 ???
- **Arrays verwenden!** (was auch sonst?)

- `[$object, $methodName]` is ein gültiges `callable`
- `[$user, 'mGetId']()` is ein Funktionsaufruf!

---

# Callables

- Typ `callable` kam erst mit PHP 5.4
-  `array_filter($array, $callback)` kam schon mit PHP 4.0.6
- 5.4 > 4.0.6 ???
- **Arrays verwenden!** (was auch sonst?)

- `[$object, $methodName]` is ein gültiges `callable`
- `[$user, 'mGetId']()` is ein Funktionsaufruf!
- Wie war das nochmal mit der Parameterreihenfolge?

---

# Callables 2
_Noch Älter. Härter. Besser._

- String sind **natürlich** auch gültige Callables
  - `array_filter([...], 'isEven')`
  - `array_map('Db::loadUser', [...])`

---

# Callables 2

- String sind **natürlich** auch gültige Callables
- Kann auch auf Objekten angewendet werden:
  ```php
  $mapper = new Mapper();

  // Russisch Roulette:
  $action = (rand(0, 100) >= 80) 
    ? 'delete' 
    : 'store';

  $mapper->$action($user);
  ```

---

# variable Variablen

- Leerzeichen in Variablennamen ein Problem? 

---

# variable Variablen

- Leerzeichen in Variablennamen ein Problem?  - **Nicht in PHP!**

---

# variable Variablen

- Leerzeichen in Variablennamen ein Problem? - **Nicht in PHP!**

```php
$variableName = '123 ist eine ungerade Zahl!';
$$variableName = 'ja!';
var_dump($GLOBALS); // ["123 ist eine ungerade Zahl!"] => string(3) "ja!"
```

---

# variable Variablen

- Leerzeichen in Variablennamen ein Problem? - **Nicht in PHP!**

```php
$variableName = '123 ist eine ungerade Zahl!';
$$variableName = 'ja!';
var_dump($GLOBALS); // ["123 ist eine ungerade Zahl!"] => string(3) "ja!"
```

```php
$a = 'traperto';
$b = 'a';
$c = 'b';
var_dump($$$c); // string(8) "traperto"
```

---

# variable Variablen

- Leerzeichen in Variablennamen ein Problem? - **Nicht in PHP!**
- Geht natürlich auch auf Objekten:
  ```php
  $id = 'id';
  if ($isRemoteUser) {
      $id = 'remote' . ucfirst($id);
  }

  $user->$id = 1; // $user->id oder $user->remoteId
  ```

---

# Footgun: Backticks

```php
var_dump("I'm not in danger, ");
var_dump('Skyler.');
var_dump(`I am the danger.`);
```

---

# Footgun: Backticks

```php
var_dump("I'm not in danger, "); // string(19) "I'm not in danger, "
var_dump('Skyler.'); // string(7) "Skyler."
var_dump(`I am the danger.`); // sh: 1: I: not found
```

---

# Footgun: Backticks

```php
var_dump("I'm not in danger, "); // string(19) "I'm not in danger, "
var_dump('Skyler.'); // string(7) "Skyler."
var_dump(`I am the danger.`); // sh: 1: I: not found
```
- Strings in Backticks (`) werden als System-Commands behandelt

---

# Footgun: 🔥 Spicy Regexes 🔥

```php
$result = preg_replace(
	'/[aeiou]/ie',
	'strtoupper("$0")',
	'traperto'
);
var_dump($result);
```

---

# Footgun: 🔥 Spicy Regexes 🔥

```php
$result = preg_replace(
	'/[aeiou]/ie',
	'strtoupper("$0")',
	'traperto'
);
var_dump($result); // string(8) "trApErtO"
```

---

# Footgun: 🔥 Spicy Regexes 🔥

```php
$result = preg_replace(
  '/[aeiou]/ie',
	'strtoupper("$0")',
	'traperto'
);
var_dump($result); // string(8) "trApErtO"
```

- Bis PHP 5.6 konnte man mit dem _e_-Modifier Regex-Ergebnisse automatisch `eval()`en.

---

# Footgun: Zahlen

```php
var_dump(12 > 013);
```

---

# Footgun: Zahlen

```php
var_dump(12 > 013); // bool(true)
```

---

# Footgun: Zahlen

- Zahlen mit voranstehender _0_ werden als oktal interpretiert:
  ```php
  var_dump(12 > 013); // bool(true)
  ```

---

# Footgun: Zahlen

- Zahlen mit voranstehender _0_ werden als oktal interpretiert:
  ```php
  var_dump(12 > 013); // bool(true)
  ```
- Aber nicht, wenn sie implizit gecastet werden:
  ```php
  var_dump(12 > "013"); // bool(false)
  var_dump(12 > "011"); // bool(true)
  ```

---

# Standard Library aus der Hölle

- Casing: `str_replace()`

---

# Standard Library aus der Hölle

- Casing: `str_replace()` vs. `strtr()`

---

# Standard Library aus der Hölle

- Casing: `str_replace()` vs. `strtr()` vs. `bin2hex()`

---

# Standard Library aus der Hölle

- Casing: `str_replace()` vs. `strtr()` vs. `bin2hex()`
- Funktionsnamen: `strpos`

---

# Standard Library aus der Hölle

- Casing: `str_replace()` vs. `strtr()` vs. `bin2hex()`
- Funktionsnamen: `str(?:i?)pos`

---

# Standard Library aus der Hölle

- Casing: `str_replace()` vs. `strtr()` vs. `bin2hex()`
- Funktionsnamen: `str(?:r?i?)pos`

---

# Standard Library aus der Hölle

- Casing: `str_replace()` vs. `strtr()` vs. `bin2hex()`
- Funktionsnamen: `str(?:r?i?)pos`
- Hebräisch: `T_PAAMAYIM_NEKUDOTAYIM`

---

# Standard Library aus der Hölle

- Casing: `str_replace()` vs. `strtr()` vs. `bin2hex()`
- Funktionsnamen: `str(?:r?i?)pos`
- Hebräisch: `T_PAAMAYIM_NEKUDOTAYIM` (`::`)

---

# Standard Library aus der Hölle

- Casing: `str_replace()` vs. `strtr()` vs. `bin2hex()`
- Funktionsnamen: `str(?:r?i?)pos`
- Hebräisch: `T_PAAMAYIM_NEKUDOTAYIM` (`::`)
- Parameterreihenfolge:
  `array_map($callback, $array)`

---

# Standard Library aus der Hölle

- Casing: `str_replace()` vs. `strtr()` vs. `bin2hex()`
- Funktionsnamen: `str(?:r?i?)pos`
- Hebräisch: `T_PAAMAYIM_NEKUDOTAYIM` (`::`)
- Parameterreihenfolge: 
  `array_map($callback, $array)` vs. `array_filter($array, $callback)`

---

# Warum gibt es diese Funktionen?

- `str_rot13()`

---

# Warum gibt es diese Funktionen?

- `str_rot13()`
- `gzgetss()`

---

# Warum gibt es diese Funktionen?

- `str_rot13()`
- `gzgetss()` (Get line from gz-file pointer and strip HTML tags)

---

# Warum gibt es diese Funktionen?

- `str_rot13()`
- `gzgetss()` (Get line from gz-file pointer and strip HTML tags)
- `php_uname()`

---

# Warum gibt es diese Funktionen?

- `str_rot13()`
- `gzgetss()` (Get line from gz-file pointer and strip HTML tags)
- `php_uname()` (On some older UNIX platforms, it may not be able to determine the current OS information in which case it will revert to displaying the OS PHP was built on. )

---

# Warum gibt es diese Funktionen?

- `str_rot13()`
- `gzgetss()` (Get line from gz-file pointer and strip HTML tags)
- `php_uname()` (On some older UNIX platforms, it may not be able to determine the current OS information in which case it will revert to displaying the OS PHP was built on. )
- `str_increment()`

---

# Warum gibt es diese Funktionen?

- `str_rot13()`
- `gzgetss()` (Get line from gz-file pointer and strip HTML tags)
- `php_uname()` (On some older UNIX platforms, it may not be able to determine the current OS information in which case it will revert to displaying the OS PHP was built on. )
- `str_increment()` (_"ABC"_ -> _"ABD"_, _"ZZ"_ -> _"AAA"_)

---

# Warum gibt es diese Funktionen?

- `str_rot13()`
- `gzgetss()` (Get line from gz-file pointer and strip HTML tags)
- `php_uname()` (On some older UNIX platforms, it may not be able to determine the current OS information in which case it will revert to displaying the OS PHP was built on. )
- `str_increment()` (_"ABC"_ -> _"ABD"_, _"ZZ"_ -> _"AAA"_)
- `is_file()`

---

# Warum gibt es diese Funktionen?

- `str_rot13()`
- `gzgetss()` (Get line from gz-file pointer and strip HTML tags)
- `php_uname()` (On some older UNIX platforms, it may not be able to determine the current OS information in which case it will revert to displaying the OS PHP was built on. )
- `str_increment()` (_"ABC"_ -> _"ABD"_, _"ZZ"_ -> _"AAA"_)
- `is_file()` (Note: The results of this function are cached.)

---

# Warum gibt es diese Funktionen?

- `str_rot13()`
- `gzgetss()` (Get line from gz-file pointer and strip HTML tags)
- `php_uname()` (On some older UNIX platforms, it may not be able to determine the current OS information in which case it will revert to displaying the OS PHP was built on. )
- `str_increment()` (_"ABC"_ -> _"ABD"_, _"ZZ"_ -> _"AAA"_)
- `is_file()` (Note: The results of this function are cached.)
- `get_current_user()`

---

# Warum gibt es diese Funktionen?

- `str_rot13()`
- `gzgetss()` (Get line from gz-file pointer and strip HTML tags)
- `php_uname()` (On some older UNIX platforms, it may not be able to determine the current OS information in which case it will revert to displaying the OS PHP was built on. )
- `str_increment()` (_"ABC"_ -> _"ABD"_, _"ZZ"_ -> _"AAA"_)
- `is_file()` (Note: The results of this function are cached.)
- `get_current_user()` (Gets the name of the owner of the **current PHP script**.)

---

# `die();`

- Resourcen
  - https\://eev.ee/blog/2012/04/09/php-a-fractal-of-bad-design/
- Fragen?
<br>
- CC BY-NC-SA 4.0