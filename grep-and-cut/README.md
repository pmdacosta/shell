## `grep` and `cut`

Filter only the firefighters

```bash
grep "firefighter" ff.dat 
```

Filter only the drivers

```bash
grep "driver" ff.dat 
```


Filter only the lieutenants

```bash
grep "lie" ff.dat 
```

Get only the driver's names

```bash
grep "driver" ff.dat | cut -d, -f1
```

Get the driver's names and where they work

```bash
grep "driver" ff.dat | cut -d, -f1,3
```

