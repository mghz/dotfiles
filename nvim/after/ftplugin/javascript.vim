

" Run both javascript and vue linters for vue files.
let b:ale_linter_aliases = ['javascript', 'vue']

" Select the eslint and vls linters.
let b:ale_linters = ['eslint', 'vls']

" enable lint on save
let b:ale_fix_on_save = 1
