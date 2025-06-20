" Auto-create temporary tsconfig.json in test directories
" This script creates a temporary tsconfig.json when opening TypeScript files in test directories
" and cleans them up when Neovim exits

" Function to check if current file is in a test directory
function! IsInTestDir()
    let l:filepath = expand('%:p')
    return l:filepath =~? '.*tests.*\.tsx\?$'
endfunction

" Function to find the test directory path
function! GetTestDir()
    let l:filepath = expand('%:p:h')
    " Find the tests directory in the path
    let l:parts = split(l:filepath, '/')
    let l:test_dir = ''
    
    for i in range(len(l:parts))
        if l:parts[i] =~? 'tests'
            let l:test_dir = join(l:parts[0:i], '/')
            break
        endif
    endfor
    
    return l:test_dir
endfunction

" Function to create temporary tsconfig.json
function! CreateTempTsconfig()
    if !IsInTestDir()
        return
    endif
    
    let l:test_dir = GetTestDir()
    if empty(l:test_dir)
        return
    endif
    
    let l:tsconfig_path = l:test_dir . '/tsconfig.json'
    
    " Check if tsconfig.json already exists
    if filereadable(l:tsconfig_path)
        return
    endif
    
    " Create the temporary tsconfig.json content
    let l:tsconfig_content = [
        \ '{',
        \ '  "extends": "../tsconfig.test.json"',
        \ '}'
    \ ]
    
    " Write the file
    call writefile(l:tsconfig_content, l:tsconfig_path)
    
    " Mark it as temporary by adding to a global list
    if !exists('g:temp_tsconfigs')
        let g:temp_tsconfigs = []
    endif
    
    if index(g:temp_tsconfigs, l:tsconfig_path) == -1
        call add(g:temp_tsconfigs, l:tsconfig_path)
    endif
    
    " Restart LSP for this buffer to pick up new tsconfig
    if exists(':LspRestart')
        LspRestart
    endif
    
    echo 'Created temporary tsconfig.json in ' . l:test_dir
endfunction

" Function to clean up temporary tsconfig files
function! CleanupTempTsconfigs()
    if !exists('g:temp_tsconfigs')
        return
    endif
    
    for l:tsconfig_path in g:temp_tsconfigs
        if filereadable(l:tsconfig_path)
            call delete(l:tsconfig_path)
            echo 'Deleted temporary tsconfig.json: ' . l:tsconfig_path
        endif
    endfor
    
    let g:temp_tsconfigs = []
endfunction

" Function to clean up tsconfig for specific directory when no more TS files are open
function! CleanupTsconfigIfUnused()
    if !IsInTestDir()
        return
    endif
    
    let l:test_dir = GetTestDir()
    if empty(l:test_dir)
        return
    endif
    
    let l:tsconfig_path = l:test_dir . '/tsconfig.json'
    
    " Check if this tsconfig is in our temp list
    if !exists('g:temp_tsconfigs') || index(g:temp_tsconfigs, l:tsconfig_path) == -1
        return
    endif
    
    " Check if any other buffers are using this test directory
    let l:other_buffers_in_dir = 0
    for l:bufnr in range(1, bufnr('$'))
        if buflisted(l:bufnr) && l:bufnr != bufnr('%')
            let l:buf_path = fnamemodify(bufname(l:bufnr), ':p:h')
            if l:buf_path =~# '^' . escape(l:test_dir, '/\')
                let l:other_buffers_in_dir = 1
                break
            endif
        endif
    endfor
    
    " If no other buffers in this directory, clean up the tsconfig
    if !l:other_buffers_in_dir
        if filereadable(l:tsconfig_path)
            call delete(l:tsconfig_path)
            call filter(g:temp_tsconfigs, 'v:val != "' . l:tsconfig_path . '"')
            echo 'Cleaned up unused tsconfig.json: ' . l:tsconfig_path
        endif
    endif
endfunction

" Auto commands
augroup TempTsconfig
    autocmd!
    " Create temp tsconfig when opening TS files in test directories
    autocmd BufRead,BufNewFile *.ts,*.tsx call CreateTempTsconfig()
    
    " Clean up when closing buffers
    autocmd BufDelete *.ts,*.tsx call CleanupTsconfigIfUnused()
    
    " Clean up all temp tsconfigs when exiting Neovim
    autocmd VimLeavePre * call CleanupTempTsconfigs()
augroup END

" Manual commands for testing
command! CreateTempTsconfig call CreateTempTsconfig()
command! CleanupTempTsconfigs call CleanupTempTsconfigs()
command! ShowTempTsconfigs echo exists('g:temp_tsconfigs') ? g:temp_tsconfigs : 'No temporary tsconfigs created'
