" Quit when a syntax file was already loaded
if !exists("main_syntax")
	if version < 600
		syntax clear
	elseif exists("b:current_syntax")
		finish
	endif

	" we define it here so that included files can test for it
	let main_syntax='apexlog'
endif

syn case match
syn keyword apexLogLevelCategory APEX_CODE APEX_PROFILING CALLOUT DB SYSTEM VALIDATION VISUALFORCE WAVE WORKFLOW
syn keyword apexLogLevelSetting NONE ERROR DEBUG WARN INFO FINE FINER FINEST
syn match apexLogTimestamp "^[0-9\:\.]\+ ([0-9]\+)"
syn keyword apexLogOperation CODE_UNIT_FINISHED CODE_UNIT_STARTED CONSTRUCTOR_ENTRY CONSTRUCTOR_EXIT CUMULATIVE_LIMIT_USAGE CUMULATIVE_LIMIT_USAGE_END CUMULATIVE_PROFILING CUMULATIVE_PROFILING_BEGIN CUMULATIVE_PROFILING_END DML_BEGIN DML_END EMAIL_QUEUE ENTERING_MANAGED_PKG EXCEPTION_THROWN EXECUTION_FINISHED EXECUTION_STARTED FATAL_ERROR HEAP_ALLOCATE LIMIT_USAGE_FOR_NS METHOD_ENTRY METHOD_EXIT SOQL_EXECUTE_BEGIN SOQL_EXECUTE_END STATEMENT_EXECUTE STATIC_VARIABLE_LIST SYSTEM_METHOD_ENTRY SYSTEM_METHOD_EXIT SYSTEM_MODE_ENTER SYSTEM_MODE_EXIT TOTAL_EMAIL_RECIPIENTS_QUEUED USER_DEBUG USER_INFO VARIABLE_ASSIGNMENT VARIABLE_SCOPE_BEGIN
syn match apexLogDelimiter "|"
syn match apexLogLineNumber "\[[0-9]\+\]"
syn keyword apexLogExternal EXTERNAL
syn match apexClassId "01p[a-zA-Z0-9]\{12\}"

hi def link apexLogLevelCategory Label
hi def link apexLogLevelSetting String
hi def link apexLogTimestamp Comment
hi def link apexLogOperation Function
hi def link apexLogDelimiter Comment
hi def link apexLogLineNumber Number
hi def link apexLogExternal Special
hi def link apexClassId String

let b:current_syntax = 'apexlog'

if main_syntax == 'apexlog'
	unlet main_syntax
endif
