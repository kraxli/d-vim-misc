"=============================================================================
" FILE: autoload/dmisc.vim
" AUTHOR: David Scherrer
" License: MIT license
"=============================================================================

let s:plugin_path = fnamemodify(expand('<sfile>'), ':p:h:h')
let s:python_scr = '/src_py3'


python3 << EOF
import sys
import vim

# Add sys.path
sys.path.insert(0, vim.eval('s:plugin_path'.s:python_scr))
from dmisc import *

EOF

function! dmisc#get_package_imports()

python3 << EOF
import_paths = get_dub_import_paths(vim.eval('g:dmisc_dub_path'))
vim.command("let g:dmisc_import_paths=" + import_paths)
EOF

return g:dmisc_import_paths
endfunction





