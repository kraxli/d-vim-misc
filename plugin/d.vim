""""""""""""""""""""""""""""""""""""""""""""
"  d-lang / d-utyls
""""""""""""""""""""""""""""""""""""""""""""

" == path settings ==
let $PATH=+'~/.dutils/D-Scanner/bin;~/.dutils/dfmt/bin'


let g:dutyl_stdImportPaths=dmisc#get_package_imports()

"""""""""""""""""""""""""""""""""""""""""""""""
"  vim-dlang-extra-highlight (extends vim.d)  "
"""""""""""""""""""""""""""""""""""""""""""""""
let g:d_class_scope_highlight = 1
let c_no_curly_error=1

"""""""""""""""""""""""""""""""""""""""""""""""
" Unit Testing
"""""""""""""""""""""""""""""""""""""""""""""""
" source: https://wiki.dlang.org/D_in_Vim
" The following function runs unittests on the current file and displays coverage information as a split window bound to left of the source window;

function! DTest()
  let l:fn = substitute(expand('%:r'), '/', '-', 'g') . '.lst'
  call delete(l:fn)
  cexpr system('dmd -cov -unittest -main -run ' . expand('%'))
  if filereadable(l:fn)
     normal gg
     execute '13vsplit' l:fn
     normal gg
     set scrollbind
     normal ^Wl
     set scrollbind
  endif
endfunction
" (note the ^W is a an actual CTRL-W, inserted with CTRL-V, CTRL-W) 


"""""""""""""""""""""""""""""""""""""""""""""""
" Commands
"""""""""""""""""""""""""""""""""""""""""""""""

augroup DCommands
	au!
	autocmd FileType d	command! DTest :call DTest()
	autocmd FileType d set efm=%*[^@]@%f\(%l\):\ %m,%f\(%l\\,%c\):\ %m,%f\(%l\):\ %m

	" --- dfmt ---
	"  for options see: https://github.com/Hackerpilot/dfmt
	autocmd FileType d	command! -nargs=* Dfmt :!dfmt <args>
	autocmd FileType d	command! Dformat :!dfmt --inplace --space_after_cast=false --max_line_length=120
		\ --soft_max_line_length=110 --brace_style=otbs %:p<cr>

augroup END



" == further settings ==
" let g:dutyl_neverAddClosingParen=1
" let g:dutyl_tagsFileName='newnamefortagsfile'

" == set path to import folders == 
" the following path seems to work:
" let g:dutyl_stdImportPaths=['/usr/include/dmd', '/usr/include/dmd/phobos']
" let g:dutyl_stdImportPaths=['/usr/include/dmd', '/usr/include/dmd/phobos', '/usr/include/phobos', '/usr/include/dmd/druntime/import', '/home/dave/.dub/packages/ggplotd-1.1.1/ggplotd/source', "/home/dave/.dub/packages/dstats-1.0.3/source", "/home/dave/.dub/packages/vibe-d-0.7.30/vibe-d/source/", "~/.dub/packages/consoled-1.0.4/source/", '/home/dave/.dub/packages/mir-0.22.0/mir/source', '/home/dave/.dub/packages/mir-0.22.0/mir/source/mir', '/home/dave/Dropbox/A_Coding/D/libdsmisc/source']


" vim: set filetype=vim :
