## Debugging steps

### bash -n` check for syntax errors

```bash
$ bash -n scream.sh
$
```

### Simple debug using `echo`

Let's add some `echo`s before and after to check the contents of `$TXT`.  

```bash
echo "TXT with whitespaces   : [$TXT]"
TXT=$(echo $TXT | tr ' ' '!')   # Switch spaces for exclamation marks
echo "TXT with exclamation   : [$TXT]"
```

When we run we get this

```
$ ./scream.sh
TXT with whitespaces   : [     scream     ]
TXT with exclamation   : [scream]
SCREAM
```

From this we can see that the `tr` command is not working as intended.

### Global debug -x, -v

With the `bash -x` option shows commands as they are exectuded and expands variables and
subshells.

```bash
bash -x scream.sh
+ TXT=scream
+ TXT='     scream     '
+ echo 'TXT with whitespaces   : [     scream     ]'
TXT with whitespaces   : [     scream     ]
++ echo scream                                          <----- notice here
++ tr ' ' '!'
+ TXT=scream
+ echo 'TXT with exclamation   : [scream]'
TXT with exclamation   : [scream]
++ echo scream
++ tr a-z A-Z
+ TXT=SCREAM
+ echo SCREAM
SCREAM
```

In the `<---- notice here` line we can see that we're piping `echo scream` instead of `echo '     scream     ' to the `tr` command. We found our bug. This is due to calling `echo $TXT` instead of `echo "$TXT"`. 

The `-v` option is similar but different, it shows the line before executing, but does not expand variables. See the differences.

```bash
$ bash -v five.sh
#!/bin/bash
# five.sh
#
# Count until five

echo $((0+1))
1
echo $((0+2))
2
echo $((0+3))
3
echo $((0+4))
4
echo $((0+5))
5
$ bash -x five.sh
+ echo 1
1
+ echo 2
2
+ echo 3
3
+ echo 4
4
+ echo 5
5
```

You can also use `bash -xv` to have both at the same time.

### Debug section only

`set -x` turns on debbuging
`set +x` turns off debbuging
`set -v` turns on verbose mode
`set +v` turns off verbose mode

You can set these in the middle or your script to turn on and off in the parts you want
to debug instead of having it turned on the whole script.

### Breakpoints with `trap`

You can set `trap read DEBUG` in your code so the code stops and waits for execution
until you press enter. You can then set `trap "" DEBUG` in the line you want the step by
step execution to stop. You can mix this with the `-vx` modes to get debbuging output.
Like so:

```bash
#!/bin/bash
# five.sh
#
# Count until five

echo $((0+1))
set -x
trap read DEBUG
echo $((0+2))
echo $((0+3))
trap "" DEBUG
set +x
echo $((0+4))
echo $((0+5))
```

### Custom `debug()` function

Since adding comments to turn on and off debbuging `echo`s starts to become annoying, you can
use a custom `debug()` function and a `DEBUG` flag to turn it on and off.

```bash
debug(){
    [ "$DEBUG" = 1 ] && echo "$*"
}
```

This will only print if `DEBUG` is set to `1`.
Like so:

```bash
#!/bin/bash
# scream.sh
# Based on Aurelio Vargas's grita.sh from the Shell Script Profissional Book
# Adapted to english
#
# Shows a word ($TXT) in uppercase and with exclamation marks
# Example: foo -> !!!!!FOO!!!!!
#

DEBUG=1

debug() {
    [ "$DEBUG" = 1 ] && echo -e "{DEBUG}: $*"
}

TXT="scream"
TXT="     $TXT     "            # Adds 5 spaces around

debug "TXT with whitespaces   : [$TXT]"
TXT=$(echo $TXT | tr ' ' '!')   # Switch spaces for exclamation marks
debug "TXT with exclamation   : [$TXT]"

TXT=$(echo $TXT | tr a-z A-Z)   # Change text to uppercase
echo "$TXT"
```

