# lk
Generate Github URL from file path.

## Usage

Basic:
```bash
./lk.sh README.md
https://github.com/gjollyNexmo/lk/blob/master/README.md
```

Vim integration, press *F1* to get the URL **with line number**:
```bash
map <F1> :echo trim(system('${PATH_TO_REPO}/lk.sh '.expand("%"))) . "#L" . line(".")<CR>
```
