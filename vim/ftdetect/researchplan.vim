" Detect research plan files (must override built-in *.txt -> text detection)
autocmd BufRead,BufNewFile */research_plan.txt set filetype=researchplan
autocmd BufRead,BufNewFile */Prompts/*.txt set filetype=researchplan
