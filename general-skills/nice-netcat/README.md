# Nice netcat...

Follow the prompt...

```bash
nc mercury.picoctf.net 21135
```

Okay, looks like a bunch of ascii codes. Let's try that first.

I know of a bash command to convert ascii code back into characters.

We can use printf:

```bash
chr() {
	printf "\\$(printf %o "$1")"
}
```

This code above converts an ascii code into octal, then converts that octal into character. It's a little trick from StackExchange.

Then we can just iterate over the output. I store the output first.

```bash
nc mercury.picoctf.net 21135 > nc.txt
```

Then let's put the scripts in a little file for editing convenience. See `ascii.sh` for the script.

Then we can source it and run it:
```bash
source ascii.sh

ascii-read nc.txt
```

And the resulting string should be the flag.
