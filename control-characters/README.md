## Control characters

To clear the screen we can send the escape sequence `ESC [ 2 J` to get `ESC` we need to use
the octal code `\033`. We use the flag `-e` to enable interpretation of backslash escapes, and
the flag `-n` to not print a new line, otherwise it can mess up the escape sequence

```bash
echo -ne '\033[2J'
```
