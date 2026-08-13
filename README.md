# feel v2.2.0

记录当前感受的命令行工具。支持中/英双语，根据 `LANG` 环境变量自动切换。

> [!IMPORTANT]
> **重要提示：** 默认文件名已由 `log` 改为 `log.feel`。日志默认保存在 `$XDG_DATA_HOME/feel/log.feel`（通常为 `~/.local/share/feel/log.feel`）。旧版本的 `log` 文件不会自动被读取，如有旧数据可直接重命名为 `log.feel`。

## 更新日志

### v2.2.0 (2026-08-13)

- 新增环境变量 `FEEL_MD_EXT`：设为 `true`（不区分大小写）时，主日志使用 `log.txt`、长文本记录使用 `*.md` 扩展名
- 默认（未设置或非 `true`）仍使用 `.feel` 扩展名（`log.feel` 与 `*.feel`），原有行为不变
- 该开关仅影响新写入文件的扩展名，既有数据与日志索引不受影响

### v2.1.0 (2026-08-13)

- 主日志文件更名为 `log.feel`，长文本记录文件扩展名由 `.md` 改为 `.feel`
- 现有数据已自动迁移（`log.txt` → `log.feel`，`long/*.md` → `long/*.feel`）

### v2.0.3 (2026-08-13)

- `feel read` 与 `feel delete` 现在支持使用 `feel list` 显示的序号（行号）作为标识符，例如 `feel read 2`、`feel delete 3`
- 仍优先按 Unix 时间戳精确匹配，未匹配到任何时间戳时才按序号解析

### v2.0.2 (2026-08-13)

- `feel list` 中长文本条目添加 `[LONG]:` 前缀，便于与普通感受区分
- 新增 `feel read <unix_timestamp | last>` 命令，直接读取长文本内容
- 新增别名 `show` → `read`

### v2.0.1 (2026-08-13)

- `feel list` 现在能正确显示长文本条目：以长文本文件的 `#` 标题作为列表标题
- 长文本默认 `#` 改为时间戳格式 `1786555451 2026-08-13 01:24`（Unix 时间戳 + 可读时间）
- 若未编辑 `#` 标题，`feel list` 中显示 `<无摘要>`

### v2.0.0 (2026-08-13)

- 新增 `feel long` 命令，用编辑器（默认 vim，可通过 `$EDITOR` 指定）撰写长文本记录
- 每个长文本记录独立保存为一个 Markdown 文件，存放在 `$XDG_DATA_HOME/feel/long/`
- 日志文件更名为 `log.txt`（原为 `log`），遵循更规范的扩展名约定

### v1.3.0 (2026-06-02)

- 新增 `feel version` 命令，显示当前版本号
- 别名 `-v` / `--version` 同样支持

### v1.2.1 (2026-06-02)

- 新增 `feel delete last` 命令，快速删除最后一条记录，无需查找时间戳
- 别名 `del` / `rm` 同样支持：`feel del last`、`feel rm last`

### v1.2.0 (2026-06-02)

- 新增 `feel help` 命令，显示完整的使用帮助和别名列表
- 新增命令别名系统，支持短命令快速操作：
  - `ls` → `list`
  - `ls -a` → `list -a`
  - `del` / `rm` → `delete`
  - `-h` / `--help` → `help`

### v1.1.1 (2026-06-02)

- `feel list` 新增 `-n <N>` 选项，支持指定显示记录数量
- `feel list` 新增 `-a` / `--all` 选项，支持显示所有记录

### v1.1.0 (2026-06-02)

- 新增 `feel delete <unix_timestamp>` 命令，支持基于 Unix 时间戳删除特定记录
- 删除前显示匹配记录并要求确认，防止误删

### v1.0.1 (2026-06-02)

- 修复交互模式下 CJK 宽字符输入丢失的问题（如"还是"被吞掉），改用 `sys.stdin.buffer.readline()` 绕过 readline

### v1.0.0 (2026-06-02)

- 初始发布
- 交互式/直接式两种记录模式
- `feel list` 查看最近 10 条日志
- 中/英双语自动切换
- XDG 规范日志存储

## 安装

### 从 Homebrew 安装 (macOS / Linux)

```bash
brew install CamelliaTse/tap/feel
```

### 从 AUR 安装 (Arch Linux)

```bash
yay -S feel
# 或
paru -S feel
```

### 手动构建 (makepkg)

```bash
git clone https://github.com/CamelliaTse/feel.git
cd feel
makepkg -si
```

### 直接安装

```bash
sudo cp feel /usr/local/bin/feel
sudo chmod +x /usr/local/bin/feel
```

## 用法

### 交互模式

```bash
feel
```

1. 提示「感受：」(en: "Feeling: ")，输入当前感受
2. 提示「备注 (可选，回车跳过)：」(en: "Note (optional, Enter to skip): ")，可输入备注或直接回车跳过
3. 在「感受：」提示下不输入直接回车即可退出

### 直接模式

```bash
feel <描述>
```

示例：

```bash
feel 我不开心
feel 今天心情不错
```

### 长文本记录

需要记录较长内容时，可用编辑器撰写：

```bash
feel long
```

1. 自动在 `$XDG_DATA_HOME/feel/long/` 下创建以当前时间命名的文件（默认 `.feel`，设置 `FEEL_MD_EXT=true` 时为 `.md`）
2. 文件的默认 `#` 标题为时间戳（`Unix时间戳 可读时间`，如 `1786555451 2026-08-13 01:24`），可改为任意标题
3. 打开 `$EDITOR`（默认 `vim`）进行编辑
4. 保存并退出后，该长文本作为独立文件保存，并在主日志中记录一条索引（`long:long/<文件名>`，扩展名与上述约定一致）
5. 若未写入任何内容直接退出，则取消本次记录并清理空文件

### 读取长文本

```bash
feel read <unix_timestamp>   # 读取指定长文本记录
feel read <序号>              # 按 list 显示的序号读取
feel read last               # 读取最后一条长文本记录
feel show <ts|序号>           # 同上（别名）
```

长文本记录与普通感受分开存储。可通过 `feel list` 查看 `[LONG]:` 标记的条目，再使用 `feel read` 读取全文。`<ts>` 既支持 Unix 时间戳，也支持 `feel list` 左侧显示的序号（行号）；优先按时间戳精确匹配，未匹配到时按序号解析。

### 查看日志

```bash
feel list           # 显示最近 10 条记录（默认）
feel list -n 20     # 显示最近 20 条记录
feel list -a        # 显示所有记录
```

显示记录，带行号。长文本条目以 `[LONG]:` 前缀标记，并以对应 `.feel` 文件的 `#` 标题作为显示标题；若未自定义标题，则显示 `<无摘要>`。

### 删除记录

```bash
feel delete <unix_timestamp>
feel delete <序号>
feel delete last
```

根据 Unix 时间戳或 `feel list` 显示的序号删除指定记录，或使用 `last` 删除最后一条记录。优先按时间戳精确匹配，未匹配到时按序号解析。

示例：

```bash
feel delete 1780334414   # 按时间戳删除
feel delete 3            # 按 list 显示的序号删除
feel delete last          # 删除最后一条记录
feel del last             # 同上（别名）
feel rm last              # 同上（别名）
```

删除前会显示匹配的记录并要求输入 `y` 确认。

### 帮助

```bash
feel help           # 显示完整帮助信息
feel -h             # 同上
feel --help         # 同上
```

### 别名

为了提高输入效率，所有命令都支持规范的别名：

| 别名 | 等价于 |
|------|--------|
| `feel ls` | `feel list` |
| `feel ls -a` | `feel list -a` |
| `feel ls -n 20` | `feel list -n 20` |
| `feel show <ts>` | `feel read <ts>` |
| `feel show last` | `feel read last` |
| `feel del <ts>` | `feel delete <ts>` |
| `feel rm <ts>` | `feel delete <ts>` |
| `feel del last` | `feel delete last` |
| `feel rm last` | `feel delete last` |
| `feel -h` | `feel help` |
| `feel --help` | `feel help` |

## 日志

日志位置遵循 XDG 规范：

- 短日志：`$XDG_DATA_HOME/feel/log.feel`（默认 `~/.local/share/feel/log.feel`）
- 长文本：`$XDG_DATA_HOME/feel/long/`（每个长文本记录一个 `.feel` 文件）

### 扩展名约定

默认使用 `.feel` 扩展名（`log.feel` 与 `long/*.feel`）。若希望恢复为文本/Markdown 扩展名，可设置环境变量：

```bash
export FEEL_MD_EXT=true   # 短日志使用 log.txt，长文本使用 *.md
```

当 `FEEL_MD_EXT` 为 `true` 时：
- 短日志：`$XDG_DATA_HOME/feel/log.txt`
- 长文本：`$XDG_DATA_HOME/feel/long/*.md`

未设置或非 `true` 时，行为与默认一致（`.feel` 扩展名）。该开关仅影响新写入文件的扩展名，不影响已有数据。

短日志格式：`unix_timestamp yyyy-mm-dd hh:mm 感受 [(备注)]`

示例：

```
   5  1780334414 2026-06-02 01:20 直接测试
   6  1780334665 2026-06-02 01:24 我真的不开心
   7  1780335079 2026-06-02 01:31 happy
```
