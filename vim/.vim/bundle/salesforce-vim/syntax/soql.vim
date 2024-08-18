" Quit when a syntax file was already loaded
if !exists("main_syntax")
	if version < 600
		syntax clear
	elseif exists("b:current_syntax")
		finish
	endif

	" we define it here so that included files can test for it
	let main_syntax='soql'
endif

" apex soql statements
syntax case ignore
syn match   soqlPunctuation      "[{}<>()\[\],.:;!=|&]"
syn keyword soqlKeyword          select typeof end from where cube having asc desc limit offset like and or includes excludes in not at above below above_or_below
syn keyword soqlDateLiteral      yesterday today tomorrow last_week this_week next_week last_month this_month next_month last_90_days next_90_days last_n_days next_n_days next_n_weeks last_n_weeks next_n_months last_n_months this_quarter last_quarter next_quarter next_n_quarters last_n_quarters this_year last_year next_n_years last_n_years this_fiscal_quarter next_fiscal_quarter next_n_fiscal_quarters last_n_fiscal_quarters this_fiscal_year last_fiscal_year next_fiscal_year next_n_fiscal_years last_n_fiscal_years
syn keyword soqlFunction         calendar_year calendar_month calendar_quarter day_in_month day_in_week day_in_year day_only fiscal_month fiscal_quarter fiscal_year hour_in_day week_in_month week_in_year tolabel rollup grouping cube convertcurrency avg count count_distinct min max sum
syn keyword soqlScope            everything mine my_territory my_team_territory team
syn match   soqlKeyword          "using\s\+scope"
syn match   soqlKeyword          "\(group\|order\)\s\+by"
syn match   soqlKeyword          "nulls\s\+\(first\|last\)"
syn match   soqlKeyword          "for\s\+\(view\|reference\)"
syn match   soqlKeyword          "update\s\+\(tracking\|viewstat\)"
syn match   soqlKeyword          "with\(\s\+data\s\+category\)\?"
syn match   soqlVariable         contains=soqlPunctuation ":[^ ]*"
syn region  soqlString           start=+'+ end=+'+ end=+$+ contains=@Spell
syntax case match

" The default highlighting.
hi def link soqlKeyword          Special
hi def link soqlVariable         Constant
hi def link soqlFunction         Function
hi def link soqlDateLiteral      Constant
hi def link soqlScope            Constant
hi def link soqlString           String
hi def link soqlPunctuation      Operator

let b:current_syntax = 'soql'

if main_syntax == 'soql'
	unlet main_syntax
endif

" vim: ts=4 sw=4 sts=4 noet
