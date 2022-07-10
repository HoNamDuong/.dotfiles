## NORMAL

### Motions: Chuyển động

|     | Left | Down | Up  | Right |     |
| :-: | :--: | :--: | :-: | :---: | :-: |
|     |      |      |  ^  |       |     |
|  <  | `h`  | `j`  | `k` |  `l`  |  >  |
|     |      |  v   |     |       |     |

| Command                | Description                                              |
| ---------------------- | -------------------------------------------------------- |
| `gg`                   | Di chuyển con trỏ lên đầu file                           |
| `G`                    | Di chuyển con trỏ xuống cuối file                        |
| `:`:1234: or :1234:`G` | Di chuyển đến dòng N                                     |
| `$`                    | Di chuyển con trỏ đến cuối dòng                          |
| `gm`                   | Di chuyển con trỏ đến giữa dòng                          |
| `0`                    | Di chuyển con trỏ đến đầu dòng                           |
| `^`                    | Di chuyển về ký tự đầu tiên không phải dấu cách của dòng |
| `w`                    | Di chuyển về phía trước một từ                           |
| `b`                    | Di chuyển về phía sau một từ                             |
| `e`                    | Di chuyển con trỏ đến cuối của từ                        |

| Command | Description            |
| ------- | ---------------------- |
| `gf`    | Open file under cursor |

### Various motions

| Command | Description                                                                                                                      |
| ------- | -------------------------------------------------------------------------------------------------------------------------------- |
| `%`     | Khi đặt cursor trên các ký tự như `(`, `[` hoặc `{` và gõ `%` thì cursor sẽ được nhảy đến phần đóng hoặc mở thẻ tương ứng với nó |
| `H`     | Di chuyển về đầu dòng đầu tiên                                                                                                   |
| `M`     | Di chuyển về đầu dòng giữa                                                                                                       |
| `L`     | Di chuyển về đầu dòng cuối                                                                                                       |

### Scrolling: Cuộn

| Command    | Description                              |
| ---------- | ---------------------------------------- |
| `zt`       | redraw, current line at top of window    |
| `zz`       | redraw, current line at center of window |
| `zb`       | redraw, current line at bottom of window |
| `Ctrl`+`u` | Cuộn lên văn bản nửa màn hình            |
| `Ctrl`+`d` | Cuộn xuống văn bản nửa màn hình          |

### Marks and motions: Đánh dấu và chuyển động

| Command     | Description                              |
| ----------- | ---------------------------------------- |
| `Ctrl`+`o`  | to go back to where you came from.       |
| `Ctrl`+`i`  | to go forward (ngược với `Ctrl`+`o`)     |
|             |                                          |
| `m`{a-zA-Z} | mark current position with mark {a-zA-Z} |
| `{a-z}      | go to mark {a-z} within current file     |
| `{A-Z}      | go to mark {A-Z} in any file             |

### Cut, Copy và Paste

| Command                 | Description                                       |
| ----------------------- | ------------------------------------------------- |
| :1234:`yy` or :1234:`Y` | Copy dòng hiện tại(N dòng phái dưới)              |
| `y$`                    | Copy đến cuối dòng                                |
| `y0`                    | Copy đến đầu dòng                                 |
| `y`                     | Copy phần văn văn bản đã chọn trong chế độ VISUAL |
| `yw`                    | Copy word                                         |
|                         |                                                   |
| :1234:`p`               | Paste phần văn bản đã lưu sau cursor (N lần)      |
| :1234:`P`               | Paste phần văn bản đã lưu trước cursor (N lần)    |

### Delete

Delete = Cut

| Command      | Description                                        |
| ------------ | -------------------------------------------------- |
| `dgg`        | Xóa đến đầu file                                   |
| `dG`         | Xóa đến cuối file                                  |
|              |                                                    |
| `d`:1234:`j` | Xóa N dòng bên dưới (delete ... j là xuống)        |
| `d`:1234:`k` | Xóa N dòng bên dưới (delete ... k là lên)          |
| `dd` or `:d` | Xóa dòng hiện tại của con trỏ                      |
| `d$` or `D`  | Xóa đến cuối dòng                                  |
| `d0`         | Xóa đến đầu dòng                                   |
| `dt`{char}   | Xóa đến ký tự {char} (delete till ...) trên dòng   |
|              |                                                    |
| `diw`        | Xóa từ tại vị trí con trỏ                          |
| `d`:1234:`w` | Xóa N từ đăng sau con trỏ (delete ... word)        |
| `d`:1234:`b` | Xóa N từ đằng trước con trỏ (delete ... backwards) |
| `de`         | Xóa đến cuối từ hiện tại                           |
| `db`         | Xóa đến đầu từ hiện tại                            |
|              |                                                    |
| `x`          | Xóa ký tự tại vị trí con trỏ                       |
| `X`          | Xóa ký tự bên trái con trỏ.                        |

### Nối dòng

| Command    | Description                           |
| ---------- | ------------------------------------- |
| :1234:`J`  | Nối N dòng phía dưới                  |
| :1234:`gJ` | Như `J` nhưng không chèn khoảng trắng |

### Inserting text: Chèn văn bản

| Command   | Description                                      |
| --------- | ------------------------------------------------ |
| :1234:`o` | Chèn dòng mới vào bên dưới dòng hiện tại (N lần) |
| :1234:`O` | Chèn dòng mới vào bên trên dòng hiện tại (N lần) |
| :1234:`I` | Chèn vào đầu dòng (N lần)                        |
| :1234:`A` | Chèn vào cuối dòng (N lần)                       |
|           |                                                  |
| :1234:`i` | Chèn phía trước con trỏ (N lần)                  |
| :1234:`a` | Chèn phía sau con trỏ (N lần)                    |

### Change

| Command         | Description                                        |
| --------------- | -------------------------------------------------- |
| :1234:`r`(char) | Thay thế/ghi đè 1 kí tự.                           |
| :1234:`R`       | Thay thế/ghi đè nhiều kí tự. Ấn `Esc` để kết thúc. |

Change = delete text and enter Insert mode

| Command            | Description                                                           |
| ------------------ | --------------------------------------------------------------------- |
| :1234:`c` `motion` | change the text that is moved over with (motion: `j`, `k`)            |
| :1234:`cc` or `S`  | Thay thế một dòng (trừ khoảng trống đầu)                              |
| `c$` or `C`        | Thay thế từ vị trí con trỏ đến cuối dòng                              |
| `c0`               | Thay thế từ vị trí con trỏ đến đầu dòng                               |
| `ce` or `cw`       | Để thay thế từ hoặc phần còn lại của từ. (ce là kết hợp giữa de và i) |
| :1234:`s`          | change N characters                                                   |

### Case

| Command      | Description                                               |
| ------------ | --------------------------------------------------------- |
| `ggguG`      | Biến tất cả chữ trong file thành lowercase                |
| `gggUG`      | Biến tất cả chữ trong file thành uppercase                |
|              |                                                           |
| `Vu`         | Lowercase dòng hiện tại                                   |
| `VU`         | Uppercase dòng hiện tại                                   |
| `g~~`        | Chuyền dòng hiện tại thành Uppercase và ngược lại         |
| `g~{motion}` | switch case for the text that is moved over with {motion} |
| `gu{motion}` | make the text that is moved over with {motion} lowercase  |
| `gU{motion}` | make the text that is moved over with {motion} uppercase  |

### Replace: Thay thế

| Command                     | Description                                                                                                                                   |
| --------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------- |
| `:s/`old`/`new              | Tìm kiếm và thay thế chuỗi old bằng chuỗi new.                                                                                                |
| `:s/`old`/`new`/g`          | Chỉ thị g cho phép thay thế toàn bộ ocurrences của từ đang tìm trong dòng hiện tại. (Bỏ chỉ thị g đi nếu chỉ muốn thay thế First occurrence). |
| `:`#1`,`#2`s/`old`/`new`/g` | Search & Replace tại những dòng cụ thể.(từ dòng #1 đến dòng #2)                                                                               |
| `:`#`,`$`s/`old`/`new`/g`   | Replace toàn bộ old thành new từ dòng # đến EOF                                                                                               |
| `:%s/`old`/`new`/g`         | Search & Replace mọi ocurrences trong toàn bộ nội dung của File.                                                                              |
| `:%s/`old`/`new`/gc`        | Search & Replace mọi ocurrences trong toàn bộ nội dung của File nhưng có prompt để xác định muốn replace occurence đó hay không.              |
| `:%s/`onward`/`forward`/gi` | Replace toàn bộ onward thành forward ở trong file, case unsensitive                                                                           |
| `:%s/^/`Start`/g`           | Thêm vào đầu của mỗi dòng bằng Start                                                                                                          |
| `:%s/$/`End`/g`             | Thêm vào cuối của mỗi dòng bằng End                                                                                                           |
| `Ctrl`+`a`                  | +1 cho số tại nơi con trỏ đang chỉ                                                                                                            |
| `Ctrl`+`x`                  | -1 cho số tại nơi con trỏ đang chỉ                                                                                                            |

### Undo/Redo commands

| Command      | Description                                           |
| ------------ | ----------------------------------------------------- |
| `u`          | Undo Để hoàn tác action trước đó                      |
| `U`          | Undo tất cả các thao tác thực hiện với dòng hiện tại. |
| `Ctrl` + `r` | Redo                                                  |
| `.`          | Lặp lại thao tác gần nhất ở Normal Mode               |

### Fold commands

| Command | Description                                                                                |
| ------- | ------------------------------------------------------------------------------------------ |
| `zo`    | Open one fold under the cursor.When a count is given, that many folds deep will be opened. |
| `zO`    | Open all folds under the cursor recursively.                                               |
| `zc`    | Close one fold under the cursor. When a count is given, that many folds deep are closed.   |
| `zC`    | Close all folds under the cursor recursively.                                              |
| `za`    | When on a closed fold: open it. When on an open fold: close it and set 'foldenable'.       |

### Surround

| Command                    | Description                                              |
| -------------------------- | -------------------------------------------------------- |
| `y s <motion> <desired>`   | Add `desired` surround around text defined by `<motion>` |
| `d s <existing>`           | Delete `existing` surround                               |
| `c s <existing> <desired>` | Change `existing` surround to `desired`                  |
| `S <desired>`              | Surround when in visual modes (surrounds full selection) |

Some examples:

-   `"test"` with cursor inside quotes type `cs"'` to end up with `'test'`
-   `"test"` with cursor inside quotes type `ds"` to end up with `test`
-   `"test"` with cursor inside quotes type `cs"t` and enter `123>` to end up with `<123>test</123>`

## COMMAND

| Command      | Description                                        |
| ------------ | -------------------------------------------------- |
| `:w`         | Lưu file.                                          |
| `:q`         | Thoát file. Lệnh sẽ vô hiệu nếu file chưa được lưu |
| `:q!`        | Thoát khỏi kể cả file chưa được lưu                |
| `:wq`        | Lưu và thoát                                       |
| `:x` or `ZZ` | Lưu và thoát. Tương tự :wq                         |
| `>>`         | Indent: Thụt lề == Tab                             |
| `<<`         | Un-Indent                                          |
| `.`          | Lặp lại thao tác gần nhất ở Normal Mode            |

### Tabs

| Command     | Description               |
| ----------- | ------------------------- |
| `:tabnew`   | Tạo tab mới               |
| `gt`        | Chuyển sang tab tiếp theo |
| `:tabfirst` | Chuyển tới Tab đầu tiên   |
| `:tablast`  | Chuyển tới Tab cuối cùng  |

### Multi-window commands: Đa cửa sổ

| Command               | Description                                                             |
| --------------------- | ----------------------------------------------------------------------- |
| `:e` filename         | Mở filenane                                                             |
| `:sp` filename        | Chia đôi màn hình theo chiều ngang và mở filename                       |
| `:vsp` filename       | Chia đôi màn hình theo chiều dọc và mở filename                         |
| `Ctrl` + `w` `motion` | Điều hướng giữa các màn hình đã chia(motion: `h`, `j`, `k`, `l`)        |
| `Ctrl` + `w` `=`      | Điều chỉnh kích thước bằng nhau cho tất cả các màn hình                 |
| `:new`                | Create a new window horizontally and start editing an empty file in it. |
| `:vnew`               | Create a new window vertically and start editing an empty file in it.   |

### Searches: Tìm kiếm

| Command     | Description                                                              |
| ----------- | ------------------------------------------------------------------------ |
| `/`word     | Tìm kiếm "word" từ trên xuống dưới                                       |
| `?`word     | Tìm kiếm "word" từ dưới lên trên                                         |
| `*`         | search forward for the identifier under the cursor                       |
| `#`         | search backward for the identifier under the cursor                      |
| `/\c`string | Tìm "string" cả chữ hoa lẫn chữ thường                                   |
|             | :1234:`n` or `N` repeat last search (in opposite direction)              |
| `f`{char}   | đến lần xuất hiện thứ N của {char} ở bên phải của dòng                   |
| `F`{char}   | đến lần xuất hiện thứ N của {char} ở bên trái của dòng                   |
|             | :1234:`;` or `,` repeat the last `f` or `F` N times (opposite direction) |

## INSERT

### Moving around

| Command              | Description                             |
| -------------------- | --------------------------------------- |
| `cursor keys`        | move cursor left/right/up/down          |
| `shift`+`left/right` | one word left/right                     |
| `shift`+`up/down`    | one screenful backward/forward          |
| `End`                | cursor after last character in the line |
| `Home`               | cursor to first character in the line   |

### Special keys

| Command    | Description               |
| ---------- | ------------------------- |
| `Ctrl`+`w` | Xóa từ trước con trỏ      |
| `Ctrl`+`u` | Xóa đến đầu dòng          |
| `Ctrl`+`t` | Thụt lề dòng hiện tại     |
| `Ctrl`+`d` | Xóa Thụt lề dòng hiện tại |

## VISUAL

| Command    | Description                                         |
| ---------- | --------------------------------------------------- |
| `V`        | Bôi đen cả dòng                                     |
| `gb`       | Bôi đen một từ                                      |
| `Ctrl`+`v` | start highlighting blockwise or stop highlighting   |
| `o`        | exchange cursor position with start of highlighting |
| `gv`       | start highlighting on previous visual area          |

### Text objects

| Command                | Description                              |
| ---------------------- | ---------------------------------------- |
| :1234:`aw`             | Select "a word"                          |
| :1234:`iw`             | Select "inner word"                      |
| :1234:`aW`             | Select "a WORD"                          |
| :1234:`iW`             | Select "inner WORD"                      |
| :1234:`as`             | Select "a sentence"                      |
| :1234:`is`             | Select "inner sentence"                  |
| :1234:`ap`             | Select "a paragraph"                     |
| :1234:`ip`             | Select "inner paragraph"                 |
| :1234:`a]`, `a[`       | select '[' ']' blocks                    |
| :1234:`i]`, `i[`       | select inner '[' ']' blocks              |
| :1234:`ab`, `a(`, `a)` | Select "a block" (from "[(" to "])")     |
| :1234:`ib`, `i)`, `i(` | Select "inner block" (from "[(" to "])") |

| Command           | Description                                                                                       |
| ----------------- | ------------------------------------------------------------------------------------------------- |
| {visual}`c`       | change the highlighted text                                                                       |
| {visual}`c`       | in Visual block mode: Change each of the selected lines with the entered text                     |
| {visual}`C`       | in Visual block mode: Change each of the selected lines until end-of-line with the entered text   |
| {visual}`~`       | switch case for highlighted text                                                                  |
| {visual}`u`       | make highlighted text lowercase                                                                   |
| {visual}`U`       | make highlighted text uppercase                                                                   |
| {visual}`d`       | delete the highlighted text                                                                       |
| {visual}`J`       | join the highlighted lines                                                                        |
| {visual}`gJ`      | like "{visual}J", but without inserting spaces                                                    |
| {visual}`y`       | yank the highlighted text into a register                                                         |
| {visual}`r`{char} | in Visual block, visual, or visual line modes: Replace each char of the selected text with {char} |
| {visual}`g?`      | perform rot13 encoding on highlighted text                                                        |
| {visual}`=`       | filter the highlighted lines through 'equalprg'                                                   |
