set enc=utf8
set fencs=utf8,gbk,gb2312,gb18030
set shiftwidth=4
set number
set noeb
set softtabstop=4
set autoindent
set cindent
set ruler
"set cursorline
set mouse=a

imap jk <Esc>
nmap <space> :



"============================================插件配置==============================================="
   
call plug#begin('~/.vim/plugged')
    "Plug 'itchyny/lightline.vim', {'branch': 'master'}
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
    Plug 'preservim/nerdtree'
    Plug 'vim-airline/vim-airline'
    Plug 'tpope/vim-fugitive'
    Plug 'airblade/vim-gitgutter'
    "Plug 'rhysd/vim-clang-format' 
    "Plug 'preservim/nerdcommenter'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'jiangmiao/auto-pairs'    
    Plug 'sainnhe/gruvbox-material'
call plug#end()




"=======================================coc.nvim===================================================="

set updatetime=200
set signcolumn=yes  " 始终显示错误标记列

" 诊断符号高亮
hi CocErrorSign ctermfg=Red guifg=#ff0000
hi CocWarningSign ctermfg=Yellow guifg=#ffcc00

" 自动触发诊断刷新
autocmd CursorHold * silent call CocActionAsync('diagnosticRefresh')
autocmd TextChanged,TextChangedI * silent call CocActionAsync('diagnosticRefresh')

let g:coc_config_home = '~/.vim'

" 当补全菜单可见时，按回车确认选择
inoremap <expr> <cr> coc#pum#visible() ? coc#pum#confirm() : "<cr>"
" 自动弹出补全菜单
set completeopt=menu,menuone,noselect

" 输入 2 个字符后触发自动补全
autocmd User CocInsertMode set completefunc=CocComplete



" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
    

"=======================================NERDTree===================================================="
 map <C-t> :NERDTreeToggle<CR>




"=======================================auto-pairs===================================================="
au Filetype FILETYPE let b:Autopairs = {"(": ")"}
au FileType php      let b:Autopairs = AutoPairsDefine({'<?' : '?>', '<?php': '?>'})



"=======================================airline===================================================="
set laststatus=2  "永远显示状态栏
let g:airline_powerline_fonts = 1  " 支持 powerline 字体
let g:airline#extensions#tabline#enabled = 1 " 显示窗口tab和buffer
let g:airline_theme='dark'  " murmur配色不错

if !exists('g:airline_symbols')
let g:airline_symbols = {}
endif

let g:airline_left_sep = '▶'
let g:airline_left_alt_sep = '❯'
let g:airline_right_sep = '◀'
let g:airline_right_alt_sep = '❮'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'

" ===== 关键：添加这些扩展 =====
let g:airline#extensions#branch#enabled = 1         " Git 分支
let g:airline#extensions#hunks#enabled = 1          " Git 变更
let g:airline#extensions#coc#enabled = 1            " Coc 集成

" ===== 自定义状态栏布局 =====
let g:airline_section_a = airline#section#create(['mode'])  " 模式指示器
let g:airline_section_b = airline#section#create(['branch', 'hunks'])  " Git 分支和变更
let g:airline_section_c = airline#section#create(['%f'])  " 文件名

" 文件类型和位置信息
let g:airline_section_x = airline#section#create(['%Y', ' ', '%{&ff}[%{&fenc}]'])

" 文件位置百分比和总行数
let g:airline_section_y = airline#section#create(['%p%%', ' ', 'L%L'])

" 行号:列号 和 错误统计
let g:airline_section_z = airline#section#create(['%l:%c', ' ', '%{CocErrorCount()}'])

" ===== Coc 错误统计函数 =====
function! CocErrorCount() abort
    let info = get(b:, 'coc_diagnostic_info', {})
    if empty(info)
        return ''
    endif

    let errors = get(info, 'error', 0)
    let warnings = get(info, 'warning', 0)

    if errors > 0 || warnings > 0
        return 'E:' . errors . ' W:' . warnings
    endif

    return ''
endfunction

" ===== Git 变更符号 =====
let g:airline#extensions#hunks#hunk_symbols = ['+', '~', '-']
let g:airline#extensions#hunks#non_zero_only = 1


"=======================================NerdCommenter===================================================="

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1

" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' }}

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" Enable NERDCommenterToggle to check all selected lines is commented or not
let g:NERDToggleCheckAllLines = 1


" ================================== 配色方案配置 ===================================
set t_Co=256                  " 启用 256 色支持
set termguicolors             " 启用真彩色支持（需要终端支持）
set background=dark           " 使用深色背景

" Gruvbox Material 配置
let g:gruvbox_material_background = 'hard' " 可选值: soft, medium, hard
let g:gruvbox_material_enable_italic = 1    " 启用斜体
let g:gruvbox_material_disable_italic_comment = 1 " 注释不使用斜体

" 应用配色方案
colorscheme gruvbox-material

" 状态栏主题匹配
let g:airline_theme = 'gruvbox_material'

" 高亮多余空格和TODO注释
hi ExtraWhitespace ctermbg=red guibg=red
hi Todo ctermbg=red guibg=red

" 标记行尾多余空格
nnoremap <leader>st :match ExtraWhitespace /\s\+$/<CR>/\s\+$/<CR>
nnoremap <leader>dt :match<CR>:noh<CR>


" =============== 剪贴板集成 ===============
" 启用系统剪贴板
set clipboard=unnamedplus

" 复制到宿主机剪贴板
vnoremap <leader>y :w !xclip -sel clip<CR><CR>
nnoremap <leader>y :.w !xclip -sel clip<CR><CR>

" 从宿主机剪贴板粘贴
nnoremap <leader>p :r !xclip -o -sel clip<CR>
vnoremap <leader>p :r !xclip -o -sel clip<CR>

" 备用复制粘贴快捷键
vnoremap <C-c> :w !xclip -sel clip<CR><CR>
inoremap <C-v> <ESC>:r !xclip -o -sel clip<CR>i


























































" ======================================================以前配置，现在无用==================================================="
"map <C-n> :NERDTreeToggle<CR>"
"let g:coc_disable_startup_waning = 1
"augroup AutopairsConfi"    autocmd!
"    " 定义全局的自动全规则
"    autocmd FileTyp * let b:AutoPairs = {
"                \ "(":")", 
"                \ "<":">", 
"                \ "{":"}", 
"                \ "[":"]", 
"                \ '"':'"' 
"                \ }
"
"    " 为 PHP 文件类型定义特殊的自动补全规则
"    autocmd FileType php let b:AutoPairs = {
"                \ "<?" : "?>",
"                \ "<?php": "?>",
"                \ "[":"]",
"                \ '"':'"'
"                \ }
"augroup END
"
"" 使用 Tab 键来确认补全列表中的当前选项  
"inoremap <expr> <Tab> coc#pum#visible() ? coc#pum#confirm() : "\<Tab>" 
"
"
"set laststatus=2  "永远显示状态栏
"let g:airline_powerline_fonts = 1  " 支持 powerline 字体
"let g:airline#extensions#tabline#enabled = 1 " 显示窗口tab和buffer
"let g:airline_theme='dark'  " murmur配色不错
"
"if !exists('g:airline_symbols')
"let g:airline_symbols = {}
"endif
"let g:airline_left_sep = '▶'
"let g:airline_left_alt_sep = '❯'
"let g:airline_right_sep = '◀'
"let g:airline_right_alt_sep = '❮'
"let g:airline_symbols.linenr = '¶'
"let g:airline_symbols.branch = '⎇'
"
"" Add spaces after comment delimiters by default
"let g:NERDSpaceDelims = 1
"
"" Use compact syntax for prettified multi-line comments
"let g:NERDCompactSexyComs = 1
"
"" Align line-wise comment delimiters flush left instead of following code indentation
"let g:NERDDefaultAlign = 'left'
"
"" Set a language to use its alternate delimiters by default
"let g:NERDAltDelims_java = 1
"
"" Add your own custom formats or override the defaults
"let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' }}
"
"" Allow commenting and inverting empty lines (useful when commenting a region)
"let g:NERDCommentEmptyLines = 1
"
"" Enable trimming of trailing whitespace when uncommenting
"let g:NERDTrimTrailingWhitespace = 1
"
"" Enable NERDCommenterToggle to check all selected lines is commented or not
"let g:NERDToggleCheckAllLines = 1
"
"
"" 配置 clang-format
"let g:clang_format#auto_format_on_save = 1  " 保存时自动格式化
"let g:clang_format#style_options = {
"\   "BasedOnStyle": "Google",
"\   "IndentWidth": 4,
"\   "TabWidth": 4,
"\   "UseTab": "Never"
"\ }
"autocmd FileType c,cpp nnoremap <F5> :ClangFormat<CR>






" =============== 环境兼容性设置 ===============
" 检测是否在 tmux 中运行
if exists('$TMUX')
  " 设置与外部终端相同的终端类型
  set term=xterm-256color

  " 强制真彩色支持
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

" =============== 配色方案安全加载 ===============
" 确保插件已加载后再设置配色
augroup SafeColorscheme
  autocmd!
  autocmd VimEnter * call SetColorsafe()
augroup END

function! SetColorsafe()
  try
    colorscheme gruvbox-material
    set background=dark
  catch /^Vim\%((\a\+)\)\=:E185/
    " 备选方案
    try
      source $VIMRUNTIME/colors/default.vim
    catch
      " 最简回退
      highlight Normal ctermbg=NONE guibg=NONE
    endtry
  endtry
endfunction

" =============== 字体一致性设置 ===============
if has('gui_running')
  set guifont=FiraCode\ Nerd\ Font\ Mono:h12  " 替换为您使用的字体
else
  " 在终端中强制使用等宽字体
  if exists('$TMUX')
    set guifont=!
  endif
endif
