# btw: get_tools()

The following is the output from: 

``` r
chat <- btw_client()
chatget_tools()
```

~~~
$btw_tool_cran_search
# <ellmer::ToolDef> btw_tool_cran_search(query, format, n_results, `_intent`)
# @name: btw_tool_cran_search
# @description: Search for an R package on CRAN.

## Search Behavior
- Prioritizes exact phrase matches over individual words
- Falls back to word matching only when phrase matching fails

## Query Strategy
- Submit separate searches for distinct concepts (e.g., `flights`, `airlines`)
- Break multi-concept queries (e.g., `flights airlines data API`) into multiple searches and synthesize results
- Search for single, specific technical terms that package authors would use
- If the search result includes more than a 1000 results, refine your query and try again.

## Examples
Good: Search for `"permutation test"` or just `"permutation"`
Bad: Search for `"statistical analysis tools for permutation test"`
# @convert: TRUE
#
function (query, format = c("short", "long"), n_results = NULL, 
    `_intent` = "") 
{
    check_string(query)
    format <- arg_match(format)
    if (is.null(n_results)) {
        n_results <- switch(format, short = 10, long = 5)
    }
    check_number_whole(n_results)
    res <- pkg_search(query, format = format, size = n_results)
    btw_tool_result(value = btw_this(res, for_tool_use = TRUE), 
        data = res, display = list(markdown = md_table(res)), 
        cls = BtwSearchPackageToolResult)
}
<environment: namespace:btw>

$btw_tool_cran_package
# <ellmer::ToolDef> btw_tool_cran_package(package_name, `_intent`)
# @name: btw_tool_cran_package
# @description: Describe a CRAN package. Shows the title, description, dependencies and author information for a package on CRAN, 
regardless of whether the package is installed or not.
# @convert: TRUE
#
function (package_name, `_intent` = "") 
{
    check_string(package_name)
    pkg <- cran_package(package_name)
    value <- btw_this(pkg)
    BtwSearchPackageInfoToolResult(value = value, extra = list(info = pkg, 
        display = list(title = sprintf("{%s} Package Info", pkg$Package), 
            markdown = value, show_request = FALSE)))
}
<environment: namespace:btw>

$btw_tool_docs_package_news
# <ellmer::ToolDef> btw_tool_docs_package_news(package_name, search_term, `_intent`)
# @name: btw_tool_docs_package_news
# @description: Read the release notes (NEWS) for a package.

Use this tool when you need to learn what changed in a package release, i.e. when code no longer works after a package update, or 
when the user asks to learn about new features.

If no search term is provided, the release notes for the current installed version are returned. If a search term is provided, the 
tool returns relevant entries in the NEWS file matching the search term from the most recent 5 versions of the package where the 
term is matched.

Use a search term to learn about recent changes to a function, feature or argument over the last few package releases. For example, 
if a user recently updated a package and asks why a function no longer works, you can use this tool to find out what changed in the 
package release notes.
# @convert: TRUE
#
function (package_name, search_term = "", `_intent` = "") 
{
    news <- package_news_search(package_name, search_term %||% 
        "")
    if (nrow(news) == 0) {
        if (nzchar(search_term)) {
            cli::cli_abort("No NEWS entries found for package '{package_name}' matching '{search_term}'.")
        }
        else {
            cli::cli_abort("No NEWS entries found for package '{package_name}' v{package_version(package_name)}.")
        }
    }
    result <- unclass(btw_this(news))
    BtwPackageNewsToolResult(result, extra = list(display = list(markdown = result)))
}
<environment: namespace:btw>

$btw_tool_docs_package_help_topics
# <ellmer::ToolDef> btw_tool_docs_package_help_topics(package_name, `_intent`)
# @name: btw_tool_docs_package_help_topics
# @description: Get available help topics for an R package.
# @convert: TRUE
#
function (package_name, `_intent` = "") 
{
    check_installed(package_name)
    help_db <- help.search("", package = package_name, fields = c("alias", 
        "title"), ignore.case = TRUE)
    res <- help_db$matches
    res <- dplyr::group_by(res, Name)
    res <- dplyr::summarize(res, topic_id = dplyr::first(Name), 
        title = dplyr::first(Entry[Field == "Title"]), aliases = list(I(Entry[Field == 
            "alias"])))
    res <- dplyr::ungroup(res)
    res <- dplyr::select(res, topic_id, title, aliases)
    ret <- btw_tool_env_describe_data_frame_impl(res, format = "json", 
        max_rows = Inf, max_cols = Inf)
    ret@extra$display <- list(title = sprintf("{%s} Help Topics", 
        package_name), markdown = md_table(res))
    ret
}
<environment: namespace:btw>

$btw_tool_docs_help_page
# <ellmer::ToolDef> btw_tool_docs_help_page(package_name, topic, `_intent`)
# @name: btw_tool_docs_help_page
# @description: Get help page from package.
# @convert: TRUE
#
function (topic, package_name = "", `_intent` = "") 
{
    if (identical(package_name, "")) {
        package_name <- NULL
    }
    if (!is.null(package_name)) {
        check_installed(package_name)
    }
    withr::local_options(list(menu.graphics = FALSE))
    help_page <- inject(help(package = !!package_name, topic = !!topic, 
        help_type = "text", try.all.packages = !!(is.null(package_name))))
    if (!length(help_page)) {
        cli::cli_abort(c(paste0("No help page found for topic {.val {topic}}", 
            if (!is.null(package_name)) {
                " in package {.pkg {package_name}}"
            } else {
                " in all installed packages"
            }, "."), i = if (!is.null(package_name)) {
            "To search in all packages, call `btw_tool_docs_help_page()` with an empty string for {.code package_name}."
        }))
    }
    resolved <- help_package_topic(help_page)
    if (length(resolved$resolved) > 1) {
        calls <- sprintf("{\"topic\":\"%s\", \"package_name\":\"%s\"}", 
            resolved$resolved, resolved$package)
        calls <- set_names(calls, "*")
        cli::cli_abort(c("Topic {.val {topic}} matched {length(resolved$resolved)} different topics.", 
            i = "Choose one or submit individual tool calls for each topic.", 
            cli_escape(calls)))
    }
    md <- format_help_page_markdown(help_page, options = c("--shift-heading-level-by=1"))
    first_empty <- match(TRUE, !nzchar(md), nomatch = 1) - 1
    if (first_empty > 0) {
        md <- md[-seq_len(first_empty)]
    }
    heading <- sprintf("## `help(package = \"%s\", \"%s\")`", 
        resolved$package, topic)
    help_call <- format(call2("::", sym(resolved$package), sym(topic)))
    BtwHelpPageToolResult(value = c(heading, md), extra = list(help_text = md, 
        topic = basename(resolved$topic), package = resolved$package, 
        display = list(title = HTML(sprintf("<code>?%s</code>", 
            help_call)), markdown = paste(md, collapse = "\n"))))
}
<environment: namespace:btw>

$btw_tool_docs_available_vignettes
# <ellmer::ToolDef> btw_tool_docs_available_vignettes(package_name, `_intent`)
# @name: btw_tool_docs_available_vignettes
# @description: List available vignettes for an R package. Vignettes are articles describing key concepts or features of an R 
package. Returns the listing as a JSON array of `vignette` and `title`. To read a vignette, use 
`btw_tool_docs_vignette(package_name, vignette)`.
# @convert: TRUE
#
function (package_name, `_intent` = "") 
{
    check_installed(package_name)
    vignettes <- as.data.frame(tools::getVignetteInfo(package = package_name))
    if (nrow(vignettes) == 0) {
        cli::cli_abort("Package {.pkg {package_name}} has no vignettes.")
    }
    df <- vignettes[, c("Topic", "Title")]
    names(df) <- c("vignette", "title")
    btw_tool_result(value = strsplit(as_json_rowwise(df), "\n")[[1]], 
        data = df, display = list(title = sprintf("{%s} Vignettes", 
            package_name), markdown = md_table(df)))
}
<environment: namespace:btw>

$btw_tool_docs_vignette
# <ellmer::ToolDef> btw_tool_docs_vignette(package_name, vignette, `_intent`)
# @name: btw_tool_docs_vignette
# @description: Get a package vignette in plain text.
# @convert: TRUE
#
function (package_name, vignette = package_name, `_intent` = "") 
{
    check_installed(package_name)
    check_string(vignette, allow_null = TRUE)
    vignettes <- as.data.frame(tools::getVignetteInfo(package = package_name))
    if (nrow(vignettes) == 0) {
        cli::cli_abort("Package {.pkg {package_name}} has no vignettes.")
    }
    vignette_info <- vignettes[vignettes$Topic == vignette, , 
        drop = FALSE]
    if (nrow(vignette_info) == 0) {
        cli::cli_abort("No vignette {.val {vignette}} for package {.pkg {package_name}} found.")
    }
    html_vignette <- pandoc_convert(file.path(vignette_info$Dir, 
        "doc", vignette_info$PDF), to = "html")
    md_vignette <- pandoc_html_simplify(html_vignette)
    btw_tool_result(md_vignette, data = vignette_info, display = list(title = sprintf("{%s} Vignette: %s", 
        package_name, vignette_info$Title), markdown = paste(md_vignette, 
        collapse = "\n")))
}
<environment: namespace:btw>

$btw_tool_env_describe_data_frame
# <ellmer::ToolDef> btw_tool_env_describe_data_frame(data_frame, package, format, max_rows, max_cols, `_intent`)
# @name: btw_tool_env_describe_data_frame
# @description: Show the data frame or table or get information about the structure of a data frame or table.
# @convert: TRUE
#
function (data_frame, format = c("skim", "glimpse", "print", 
    "json"), max_rows = 5, max_cols = 100, package = NULL, `_intent` = "") 
{
    format <- arg_match(format)
    max_rows <- max_rows %||% 5
    max_cols <- max_cols %||% 100
    check_number_whole(max_rows, allow_infinite = TRUE)
    check_number_whole(max_cols, allow_infinite = TRUE)
    if (inherits(data_frame, "character")) {
        .data_name <- data_frame
        data_frame <- get0(.data_name, ifnotfound = missing_arg())
        if (is_missing(data_frame)) {
            data_frame <- get_dataset_from_package(.data_name, 
                package = package)
        }
        if (is_missing(data_frame)) {
            cli::cli_abort(c("The data frame {.val {(.data_name)}} was not found in the environment.", 
                i = "If the data is from a package, use {.arg package} to specify the package name."))
        }
    }
    if (format != "json" && ncol(data_frame) <= 10 && nrow(data_frame) <= 
        30) {
        data_frame_md <- md_table(data_frame)
        return(btw_tool_result(value = data_frame_md, data = data_frame, 
            display = list(title = "View Data Frame", markdown = data_frame_md)))
    }
    if (format %in% c("print", "json")) {
        n_row <- min(max_rows, nrow(data_frame))
        n_col <- min(max_cols, ncol(data_frame))
        data_frame <- data_frame[seq_len(n_row), seq_len(n_col), 
            drop = FALSE]
    }
    res <- switch(format, glimpse = describe_data_frame_glimpse(x = data_frame), 
        print = describe_data_frame_print(x = data_frame), json = describe_data_frame_json(x = data_frame), 
        skim = describe_data_frame_skim(data_frame))
    btw_tool_result(value = res, data = data_frame, display = list(title = "View Data Frame"))
}
<environment: namespace:btw>

$btw_tool_env_describe_environment
# <ellmer::ToolDef> btw_tool_env_describe_environment(items, `_intent`)
# @name: btw_tool_env_describe_environment
# @description: List and describe items in the R session's global environment.
# @convert: TRUE
#
function (items = NULL, `_intent` = "") 
{
    btw_tool_env_describe_environment_impl(items = items)
}
<environment: 0x7faa11ba8818>

$btw_tool_files_edit
# <ellmer::ToolDef> btw_tool_files_edit(path, edits, `_intent`)
# @name: btw_tool_files_edit
# @description: Edit a text file using hashline references for precise, targeted modifications.

WHEN TO USE:
Use this tool when you need to modify specific lines in a file. It uses hashline
references from btw_tool_files_read (e.g., "42:a3f") to ensure you're editing
exactly the lines you intend, even if the file has been modified.

EDIT ACTIONS:
- "replace": Replace a single line with new content. Use `content: []` to delete the line.
- "insert_after": Insert new lines after a reference. Use `line: "0:000"` to insert at the start of the file.
- "replace_range": Replace multiple consecutive lines. Format: `line: "start:hash,end:hash"`.

RESPONSE FORMAT:
Returns updated hashlines for edited regions plus surrounding context (1 line before/after).
Includes shift hints when line numbers change, allowing you to chain multiple edits
without re-reading the entire file.

WORKFLOW:
1. Read the file with btw_tool_files_read to get hashlines.
2. Make edits using the line references from the read response.
3. For follow-up edits, use hashlines from the edit response and apply any shift hints.
4. If a hash mismatch error occurs, re-read the file to get fresh references.

NOTES:
- Multiple edits in one call are applied atomically (all succeed or all fail).
- Edits must not have overlapping line ranges.
- Each element in `content` is one line; do not include trailing newlines.
    
# @convert: FALSE
#
function (path, edits, `_intent` = "") 
{
    check_string(path)
    check_path_within_current_wd(path)
    if (!fs::is_file(path) || !fs::file_exists(path)) {
        cli::cli_abort("Path {.path {path}} is not a file or does not exist.")
    }
    if (!is.list(edits) || length(edits) == 0) {
        cli::cli_abort("The `edits` parameter must be a non-empty list of edit operations.")
    }
    file_lines <- read_lines(path)
    previous_content <- paste(file_lines, collapse = "\n")
    edits_parsed <- lapply(edits, function(edit) {
        action <- edit$action %||% cli::cli_abort("Each edit must have an 'action' field.")
        line_str <- edit$line %||% cli::cli_abort("Each edit must have a 'line' field.")
        content <- edit$content %||% character()
        content <- as.character(content)
        if (!action %in% c("replace", "insert_after", "replace_range")) {
            cli::cli_abort("Invalid action: {.val {action}}. Must be 'replace', 'insert_after', or 'replace_range'.")
        }
        parsed <- parse_edit_line_field(line_str)
        if (action == "replace_range" && parsed$start$line >= 
            parsed$end$line) {
            cli::cli_abort("For 'replace_range', start line must be less than end line. Got: {.val {line_str}}.")
        }
        list(action = action, start = parsed$start, end = parsed$end, 
            content = content)
    })
    validate_edit_hashes(edits_parsed, file_lines)
    check_edit_overlaps(edits_parsed)
    new_lines <- apply_edits(file_lines, edits_parsed)
    new_content <- paste(new_lines, collapse = "\n")
    write_file(new_content, path)
    response_value <- build_edit_response(path = path, new_lines = new_lines, 
        old_line_count = length(file_lines), edits_parsed = edits_parsed)
    BtwFileDiffToolResult(response_value, extra = list(path = path, 
        content = new_content, previous_content = previous_content, 
        display = list(markdown = md_code_block(fs::path_ext(path), 
            new_content), title = HTML(title_with_open_file_button("Edit", 
            path)), show_request = FALSE, icon = tool_icon("file-save"))))
}
<environment: namespace:btw>

$btw_tool_files_list
# <ellmer::ToolDef> btw_tool_files_list(path, type, regexp, `_intent`)
# @name: btw_tool_files_list
# @description: List files or directories in the project.

WHEN TO USE:
* Use this tool to discover the file structure of a project.
* When you want to understand the project structure, use `type = "directory"` to list all directories.
* When you want to find a specific file, use `type = "file"` and `regexp` to filter files by name or extension.

CAUTION: Do not list all files in a project, instead prefer listing files in a specific directory with a `regexp` to filter to files
of interest.
      
# @convert: TRUE
#
function (path = NULL, type = c("any", "file", "directory"), 
    regexp = "", `_intent` = "") 
{
    btw_tool_files_list_impl(path = path, type = type, regexp = regexp, 
        check_within_wd = TRUE)
}
<environment: 0x7faa11c7d928>

$btw_tool_files_read
# <ellmer::ToolDef> btw_tool_files_read(path, line_start, line_end, `_intent`)
# @name: btw_tool_files_read
# @description: Read the contents of a text file.

OUTPUT FORMAT:
Each line is prefixed with `line_number:hash|` where:
- `line_number` is the 1-based line number
- `hash` is a 3-character content hash used for edit validation
- `|` separates the prefix from the actual line content

Example output:
  1:a3f|library(dplyr)
  2:b1c|data <- read_csv('input.csv')
  3:d4e|result <- data |> filter(x > 0)

USAGE NOTES:
- Use line references (e.g., '2:b1c') with btw_tool_files_edit to make targeted edits.
- For large files, use line_start and line_end to read specific sections.
- Binary files (images, compiled code, etc.) cannot be read with this tool.
# @convert: TRUE
#
function (path, line_start = 1, line_end = 1000, `_intent` = "") 
{
    btw_tool_files_read_impl(path = path, line_start = line_start, 
        line_end = line_end, check_within_wd = TRUE, include_hashline = TRUE)
}
<environment: 0x7faa11d6e9d8>

$btw_tool_files_replace
# <ellmer::ToolDef> btw_tool_files_replace(path, old_string, new_string, replace_all, `_intent`)
# @name: btw_tool_files_replace
# @description: Find and replace exact string occurrences in a text file.

WHEN TO USE:
Use this tool for simple, exact text replacements when you know the precise string to
change. Ideal for renaming variables, updating values, or making repetitive changes.
For line-based structural edits, use btw_tool_files_edit instead.

HOW IT WORKS:
1. Searches for `old_string` as an exact literal match (not a regex).
2. By default, requires exactly one match to prevent unintended changes.
3. Use `replace_all: true` to replace all occurrences when intentional.

TIPS FOR SUCCESS:
- Include enough surrounding context in `old_string` to make it unique.
- Whitespace and indentation must match exactly.
- To delete text, use an empty string for `new_string`.
- If the match is ambiguous, add more context rather than using replace_all.
    
# @convert: TRUE
#
function (path, old_string, new_string, replace_all = FALSE, 
    `_intent` = "") 
{
    check_string(path)
    check_string(old_string, allow_empty = FALSE)
    check_string(new_string)
    check_bool(replace_all)
    check_path_within_current_wd(path)
    if (!fs::is_file(path) || !fs::file_exists(path)) {
        cli::cli_abort("Path {.path {path}} is not a file or does not exist.")
    }
    if (old_string == new_string) {
        cli::cli_abort("{.arg old_string} and {.arg new_string} must be different.")
    }
    previous_content <- read_file(path)
    match_positions <- gregexpr(old_string, previous_content, 
        fixed = TRUE)[[1]]
    n_matches <- if (match_positions[1] == -1L) 
        0L
    else length(match_positions)
    if (n_matches == 0L) {
        cli::cli_abort(c("{.arg old_string} was not found in {.path {path}}.", 
            i = "Make sure the string matches exactly, including whitespace and indentation."))
    }
    if (!replace_all && n_matches > 1) {
        cli::cli_abort(c("{.arg old_string} appears {n_matches} times in {.path {path}}.", 
            i = "Provide more surrounding context in {.arg old_string} to make it unique, or set {.arg replace_all} to {.code TRUE}."))
    }
    new_content <- gsub(old_string, new_string, previous_content, 
        fixed = TRUE)
    write_file(new_content, path)
    n_replaced <- if (replace_all) 
        n_matches
    else 1L
    msg <- sprintf("Replaced %d occurrence%s in %s.", n_replaced, 
        if (n_replaced != 1) 
            "s"
        else "", path)
    BtwFileDiffToolResult(msg, extra = list(path = path, content = new_content, 
        previous_content = previous_content, display = list(markdown = md_code_block(fs::path_ext(path), 
            new_content), title = HTML(title_with_open_file_button("Replace", 
            path)), show_request = FALSE, icon = tool_icon("file-save"))))
}
<environment: namespace:btw>

$btw_tool_files_search
# <ellmer::ToolDef> btw_tool_files_search(term, limit, case_sensitive, use_regex, show_lines, `_intent`)
# @name: btw_tool_files_search
# @description: Search code files in the project.

Use this tool to find references to specific code or terms in the project.
The tool returns a list of files and lines of code that match the search `term`.
`term` is the only required argument, only adjust the arguments if necessary.

Use the `btw_tool_files_read` tool, if available, to read the full content of a file found in this search.
      
# @convert: TRUE
#
function (term, limit = 100, case_sensitive = TRUE, use_regex = FALSE, 
    show_lines = FALSE, `_intent` = "") 
{
    project_code_search(term, limit = limit, case_sensitive = case_sensitive, 
        use_regex = use_regex, show_lines = show_lines)
}
<environment: 0x7faa11ed0bd0>

$btw_tool_files_write
# <ellmer::ToolDef> btw_tool_files_write(path, content, `_intent`)
# @name: btw_tool_files_write
# @description: Write content to a text file.

If the file doesn't exist, it will be created, along with any necessary parent directories.

WHEN TO USE:
Use this tool only when the user has explicitly asked you to write or create a file.
Do not use for temporary or one-off content; prefer direct responses for those cases.
Consider checking with the user to ensure that the file path is correct and that they want to write to a file before calling this 
tool.

CAUTION:
This completely overwrites any existing file content.
To modify an existing file, first read its content using `btw_tool_files_read`, make your changes to the text, then write back the 
complete modified content.
# @convert: TRUE
#
function (path, content, `_intent` = "") 
{
    check_string(path)
    check_string(content)
    check_path_within_current_wd(path)
    if (fs::is_dir(path)) {
        cli::cli_abort("Path {.path {path}} is a directory, not a file. Please provide a file path.")
    }
    dir_path <- fs::path_dir(path)
    if (dir_path != "." && !fs::dir_exists(dir_path)) {
        fs::dir_create(dir_path, recurse = TRUE)
    }
    previous_content <- if (fs::file_exists(path)) 
        read_file(path)
    write_file(content, path)
    BtwFileDiffToolResult("Success", extra = list(path = path, 
        content = content, previous_content = previous_content, 
        display = list(markdown = md_code_block(fs::path_ext(path), 
            content), title = HTML(title_with_open_file_button("Write", 
            path)), show_request = FALSE, icon = tool_icon("file-save"))))
}
<environment: namespace:btw>

$btw_tool_git_status
# <ellmer::ToolDef> btw_tool_git_status(include, pathspec, `_intent`)
# @name: btw_tool_git_status
# @description: Show the status of the git working directory.

WHEN TO USE:
* Use this tool to see which files have been modified, staged, or are untracked.
* This is typically the first tool to call when working with git operations.
* If a staged file also has unstaged modifications, only the staged file and status are listed.

RETURNS: A list of file paths, their status (new, modified, deleted, etc.), and whether they are staged or unstaged.
      
# @convert: TRUE
#
function (include = c("both", "staged", "unstaged"), pathspec = NULL, 
    `_intent` = "") 
{
    check_installed("gert")
    include <- arg_match(include)
    check_character(pathspec, allow_null = TRUE)
    staged <- switch(include, both = NULL, staged = TRUE, unstaged = FALSE)
    status <- gert::git_status(staged = staged, pathspec = pathspec)
    if (nrow(status) == 0) {
        return(btw_tool_result("No changes to report"))
    }
    md_res <- glue_("{{ status$file }} [{{ status$status }}]{{ ifelse(status$staged, ' +staged', ' -unstaged') }}")
    btw_tool_result(paste(md_res, collapse = "\n"), data = status, 
        display = list(markdown = paste("*", md_res, collapse = "\n")))
}
<environment: namespace:btw>

$btw_tool_git_diff
# <ellmer::ToolDef> btw_tool_git_diff(ref, `_intent`)
# @name: btw_tool_git_diff
# @description: View changes in the working directory or a commit.

WHEN TO USE:
* Use with no arguments to see unstaged changes (working directory vs. index).
* Use with `ref = "HEAD"` to see staged changes (index vs. HEAD).
* Use with `ref = "commit_sha"` to see the diff of that commit.

RETURNS: A unified diff patch showing the changes for a single commit.

LIMITATION: This tool does not support diffing between two arbitrary commits.
      
# @convert: TRUE
#
function (ref = NULL, `_intent` = "") 
{
    check_installed("gert")
    check_string(ref, allow_null = TRUE)
    diff_patch <- gert::git_diff_patch(ref = ref)
    if (length(diff_patch) == 0 || all(!nzchar(diff_patch))) {
        msg <- if (is.null(ref)) {
            "No unstaged changes to show"
        }
        else {
            sprintf("No changes to show for ref: %s", ref)
        }
        return(btw_tool_result(msg))
    }
    value <- md_code_block("diff", diff_patch)
    btw_tool_result(value, display = list(markdown = value, title = HTML(sprintf("Git Diff%s", 
        if (!is.null(ref)) sprintf(" (%s)", ref) else ""))))
}
<environment: namespace:btw>

$btw_tool_git_log
# <ellmer::ToolDef> btw_tool_git_log(ref, max, after, `_intent`)
# @name: btw_tool_git_log
# @description: Show the commit history for a repository.

WHEN TO USE:
* Use this tool to view recent commits and their messages.
* Useful for understanding the history of changes before making new commits.
* Can filter by branch, number of commits, or date range.

RETURNS: A list of commits with SHA (short), author, timestamp, number of files, and message.
      
# @convert: TRUE
#
function (ref = "HEAD", max = 10, after = NULL, `_intent` = "") 
{
    check_installed("gert")
    check_string(ref)
    check_number_whole(max, min = 1)
    check_string(after, allow_null = TRUE)
    log <- gert::git_log(ref = ref, max = max, after = after)
    if (nrow(log) == 0) {
        return(btw_tool_result("No commits found"))
    }
    names(log)[names(log) == "files"] <- "n_files"
    fields <- c("message", "author", "time", "n_files", "commit")
    log_display <- log
    log_display$commit <- substr(log_display$commit, 1, 7)
    log_display$message <- vapply(log_display$message, function(msg) {
        first_line <- strsplit(msg, "\n")[[1]][1]
        if (nchar(first_line) > 60) {
            paste0(substr(first_line, 1, 57), "...")
        }
        else {
            first_line
        }
    }, character(1))
    btw_tool_result(md_kv_table(log_display[fields]), data = log, 
        display = list(markdown = md_table(log_display[rev(fields)])))
}
<environment: namespace:btw>

$btw_tool_git_commit
# <ellmer::ToolDef> btw_tool_git_commit(message, files, `_intent`)
# @name: btw_tool_git_commit
# @description: Stage files and create a git commit.

WHEN TO USE:
* Use this tool to commit changes.
* If `files` is provided, those files will be staged before committing.
* If `files` is NULL, only currently staged files will be committed.

IMPORTANT:
* Always provide a clear, descriptive commit message.
* You can review changes with btw_tool_git_status and btw_tool_git_diff before committing.
* This modifies the repository state.

RETURNS: The commit SHA and confirmation message.
      
# @convert: TRUE
#
function (message, files = NULL, `_intent` = "") 
{
    check_installed("gert")
    check_string(message)
    check_character(files, allow_null = TRUE)
    if (!is.null(files)) {
        gert::git_add(files)
    }
    commit_sha <- gert::git_commit(message = message)
    result <- sprintf("Created commit: %s\nMessage: %s", substr(commit_sha, 
        1, 7), message)
    btw_tool_result(result, data = list(sha = commit_sha, message = message), 
        display = list(markdown = md_code_block("", result), 
            title = "Git Commit"))
}
<environment: namespace:btw>

$btw_tool_git_branch_list
# <ellmer::ToolDef> btw_tool_git_branch_list(include, `_intent`)
# @name: btw_tool_git_branch_list
# @description: List git branches in the repository.

WHEN TO USE:
* Use this tool to see available branches before checking out or creating a new branch.
* Shows local branches by default, but can also show remote branches.

RETURNS: A table of branch names, upstream tracking, and last update time.
      
# @convert: TRUE
#
function (include = c("local", "remote", "all"), `_intent` = "") 
{
    check_installed("gert")
    include <- arg_match(include)
    local <- switch(include, local = TRUE, remote = FALSE, all = NULL)
    branches <- gert::git_branch_list(local = local)
    if (nrow(branches) == 0) {
        return(btw_tool_result("No branches found"))
    }
    fields <- c("name", "upstream", "updated")
    branches <- branches[order(branches$updated, decreasing = TRUE), 
        ]
    branches_llm <- glue_("{{ branches$name }} [{{ branches$updated }}]{{ ifelse(!is.na(branches$upstream), paste(' ->', branches$upstream), '') }} ")
    btw_tool_result(paste(branches_llm, collapse = "\n"), data = branches, 
        display = list(markdown = md_table(branches[fields])))
}
<environment: namespace:btw>

$btw_tool_git_branch_create
# <ellmer::ToolDef> btw_tool_git_branch_create(branch, ref, checkout, `_intent`)
# @name: btw_tool_git_branch_create
# @description: Create a new git branch.

WHEN TO USE:
* Use this tool to create a new branch for feature development or bug fixes.
* By default, the new branch is checked out automatically.
* The branch is created from HEAD unless a different ref is specified.

IMPORTANT:
* This modifies the repository state.
* Ensure you're on the correct branch before creating from HEAD.

RETURNS: Confirmation message with branch name and ref.
      
# @convert: TRUE
#
function (branch, ref = "HEAD", checkout = TRUE, `_intent` = "") 
{
    check_installed("gert")
    check_string(branch)
    check_string(ref)
    check_bool(checkout)
    gert::git_branch_create(branch = branch, ref = ref, checkout = checkout)
    result <- sprintf("Created branch `%s` from `%s`%s.", branch, 
        ref, if (checkout) 
            " and checked it out"
        else "")
    btw_tool_result(result, display = list(markdown = result, 
        title = HTML(sprintf("Git Create Branch <code>%s</code>", 
            branch))))
}
<environment: namespace:btw>

$btw_tool_git_branch_checkout
# <ellmer::ToolDef> btw_tool_git_branch_checkout(branch, force, `_intent`)
# @name: btw_tool_git_branch_checkout
# @description: Switch to a different git branch.

WHEN TO USE:
* Use this tool to switch between existing branches.
* Check btw_tool_git_status first to ensure no uncommitted changes will be lost.
* Use btw_tool_git_branch_list to see available branches.

IMPORTANT:
* This modifies the repository state and working directory.
* Will fail if there are uncommitted changes unless force is true.
* Using `force: true` can lose uncommitted changes.

RETURNS: Confirmation message with branch name.
      
# @convert: TRUE
#
function (branch, force = FALSE, `_intent` = "") 
{
    check_installed("gert")
    check_string(branch)
    check_bool(force)
    gert::git_branch_checkout(branch = branch, force = force)
    result <- sprintf("Checked out branch '%s'", branch)
    btw_tool_result(result, display = list(markdown = md_code_block("", 
        result), title = HTML("Git Checkout")))
}
<environment: namespace:btw>

$btw_tool_github
# <ellmer::ToolDef> btw_tool_github(code, fields, `_intent`)
# @name: btw_tool_github
# @description: Execute R code that calls the GitHub API using gh().

WHEN TO USE:
* Use this tool to interact with GitHub repositories, issues, pull requests, and more.
* Write R code that calls gh() - you don't need to load the gh package.
* The code runs in an environment with `owner` and `repo` variables already defined.
* ALWAYS show the user a preview or description before performing write operations and allow the user to provide feedback.
* ALWAYS ask the user for confirmation before performing write or delete operations.

CODE ENVIRONMENT:
* `owner` and `repo` variables are pre-defined for the current repository
* `gh()` function is available to call any GitHub API endpoint
* `gh_whoami()` is available to get current user information
* `base64_dec()` from jsonlite is available to decode base64 content (use `rawToChar()` to convert to string)
* You can provide the endpoint with `owner` or `repo` values filled in to target another repo
* You CAN print parts of the result to the console for debugging or to show the user who will see the tool results
    * Always assemble the entire string to print and then print it in one expression with `cat()`
* Always return the result of the `gh()` call that you want to see as the final expression.
    * This result is shown automatically and SHOULD NOT be printed explicitly
    * If the data is a gh_response object, the tool will automatically limit the fields and format it
    * Otherwise, take care to return only the relevant data and to reduce the size as much as possible

ENDPOINT VALIDATION:
* Most read operations (GET) are allowed by default
* Low-risk write operations (creating issues/PRs, adding comments) are allowed
* Dangerous operations (merging PRs, deleting repos, managing webhooks/secrets) are blocked
* If an endpoint is blocked, the error message will explain how the user can allow it

EXAMPLES:
```r
# Get an issue from current repo
gh("/repos/{owner}/{repo}/issues/123", owner = owner, repo = repo)

# Get an issue from a fixed repo (tidyverse/dplyr)
gh("/repos/tidyverse/dplyr/issues/123")

# List open issues in current repository
gh("/repos/{owner}/{repo}/issues", state = "open", owner = owner, repo = repo, .limit = 10)

# Create an issue in the current repo
gh(
  "POST /repos/{owner}/{repo}/issues",
  title = "Bug report",
  body = "Description",
  owner = owner,
  repo = repo
)

# Read a repo's README
readme <- gh("/repos/posit-dev/btw/readme")
content <- base64_dec(readme$content)
cat(rawToChar(content))

# Get PR diff files in a specific repo (posit-dev/btw)
gh("/repos/posit-dev/btw/pulls/6/files")

# Target a different repo (option 1)
gh("/repos/{owner}/{repo}/issues/123", owner = "tidyverse", repo = "dplyr")
# Target a different repo (option 2)
gh("/repos/tidyverse/dplyr/issues/123")
```

RETURNS: The result from the GitHub API call, formatted as JSON.
      
# @convert: TRUE
#
function (code, fields = "default", `_intent` = "") 
{
    check_installed("gh")
    check_string(code)
    check_character(fields, allow_null = TRUE)
    if (identical(fields, "default")) {
        fields <- btw_gh_fields()
    }
    else if (identical(fields, "all")) {
        fields <- NULL
    }
    res <- btw_eval_gh_code(code, method = "evaluate")
    lv <- res@extra$data
    if (inherits(lv, "gh_response")) {
        lv <- jsonlite::toJSON(lv, auto_unbox = TRUE, pretty = TRUE)
        lv <- sprintf("<github_api_result>\n%s\n</github_api_result>", 
            lv)
    }
    if (is_string(res@value)) {
        if (inherits(res@value, "btw_run_r_no_output")) {
            res@value <- lv
        }
        else {
            res@value <- paste0(res@value, "\n\n", lv)
        }
    }
    else {
        res@value <- c(res@value, list(ellmer::ContentText(lv)))
    }
    res@extra$display$open <- FALSE
    res@extra$display$copy_code <- FALSE
    res
}
<environment: namespace:btw>

$btw_tool_ide_read_current_editor
# <ellmer::ToolDef> btw_tool_ide_read_current_editor(selection, consent, `_intent`)
# @name: btw_tool_ide_read_current_editor
# @description: Read the contents of the editor that is currently open in the user's IDE. Only use this tool when specifically asked
to do so by the user. '@current_file' and '@current_selection' are considered explicit consent.
# @convert: TRUE
#
function (selection = TRUE, consent = FALSE, `_intent` = "") 
{
    check_bool(selection)
    check_bool(consent)
    if (!consent) {
        cli::cli_abort("Please ask the user for consent before reading from the editor.")
    }
    if (!rstudioapi_has_source_editor_context()) {
        cli::cli_abort("{.field @current_file} only works in an IDE where the {.pkg rstudioapi} is available.")
    }
    cf <- rstudioapi_get_source_editor_context()
    path <- fs::path_rel(cf$path)
    has_no_selection <- length(cf$selection) == 1 && !nzchar(cf$selection[[1]]$text)
    res <- c()
    if (!selection || has_no_selection) {
        res <- c(sprintf("FILE: `%s`", path), md_code_block(type = fs::path_ext(path), 
            cf$contents))
    }
    else {
        for (selection in cf$selection) {
            if (!nzchar(selection$text)) {
                next
            }
            line_column <- function(range) {
                sprintf("L%dC%d", range[1], range[2])
            }
            line_range <- c(selection$range$start[1], selection$range$end[1])
            lines <- paste0("L", unique(line_range), collapse = "-")
            res <- c(res, if (length(res)) "", sprintf("FILE: %s:%s-%s", 
                path, line_column(selection$range$start), line_column(selection$range$end)), 
                md_code_block(type = fs::path_ext(path), strsplit(selection$text, 
                  "\n")[[1]]))
        }
    }
    BtwEditorContextToolResult(res, extra = cf)
}
<environment: namespace:btw>

$btw_tool_sessioninfo_is_package_installed
# <ellmer::ToolDef> btw_tool_sessioninfo_is_package_installed(package_name, `_intent`)
# @name: btw_tool_sessioninfo_is_package_installed
# @description: Check if a package is installed in the current session.
# @convert: TRUE
#
function (package_name, `_intent` = "") 
{
    check_installed(package_name)
    version <- package_version(package_name)
    BtwToolResult(value = glue_("Package `{{package_name}}` version {{version}} is installed."), 
        extra = list(package = package_name, version = version))
}
<environment: namespace:btw>

$btw_tool_sessioninfo_platform
# <ellmer::ToolDef> btw_tool_sessioninfo_platform(`_intent`)
# @name: btw_tool_sessioninfo_platform
# @description: Describes the R version, operating system, language and locale settings for the user's system.
# @convert: TRUE
#
function (`_intent` = "") 
{
    platform_list <- suppressWarnings(platform_info())
    platform <- trimws(capture.output(platform_list)[-1])
    platform <- sub(" +", " ", platform)
    platform <- paste(platform, collapse = "\n")
    names(platform_list) <- tolower(names(platform_list))
    BtwSessionInfoToolResult(value = sprintf("<system_info>\n%s\n</system_info>", 
        platform), extra = platform_list)
}
<environment: namespace:btw>

$btw_tool_sessioninfo_package
# <ellmer::ToolDef> btw_tool_sessioninfo_package(packages, dependencies, `_intent`)
# @name: btw_tool_sessioninfo_package
# @description: Verify that a specific package is installed, or find out which packages are in use in the current session. As a last
resort, this function can also list all installed packages.
# @convert: TRUE
#
function (packages = "attached", dependencies = "", `_intent` = "") 
{
    if (is.factor(dependencies)) {
        dependencies <- as.character(dependencies)
    }
    if (!any(nzchar(dependencies)) || identical(dependencies, 
        "FALSE") || identical(dependencies, "false")) {
        dependencies <- FALSE
    }
    if (identical(dependencies, "TRUE") || identical(dependencies, 
        "true")) {
        dependencies <- TRUE
    }
    string_with_comma <- function(x) {
        if (!is.character(x)) {
            return(FALSE)
        }
        if (length(x) != 1) {
            return(FALSE)
        }
        grepl(",", x, fixed = TRUE)
    }
    if (string_with_comma(packages)) {
        packages <- trimws(strsplit(packages, ",")[[1]])
    }
    if (string_with_comma(dependencies)) {
        dependencies <- trimws(strsplit(dependencies, ",")[[1]])
    }
    title <- NULL
    if (length(packages) == 1 && packages %in% c("loaded", "attached", 
        "installed")) {
        title <- switch(packages, loaded = "Loaded Packages", 
            attached = "Attached Packages", installed = "Installed Packages")
        title <- c(paste("###", title), "")
    }
    packages_df <- package_info(packages, dependencies)
    packages <- as.character(packages_df)
    packages <- md_code_block(type = "", packages)
    packages <- gsub(" R ", " X ", packages)
    packages <- sub("Package was removed from disk.", "Package is not installed", 
        packages)
    BtwPackageInfoToolResult(value = paste(c(title, packages), 
        collapse = "\n"), extra = list(data = packages_df, display = list(markdown = md_table(packages_df))))
}
<environment: namespace:btw>

$btw_tool_web_read_url
# <ellmer::ToolDef> btw_tool_web_read_url(url, `_intent`)
# @name: btw_tool_web_read_url
# @description: Read a web page and convert it to Markdown format.

This tool fetches the content of a web page and returns it as a simplified Markdown representation.

WHEN TO USE: Use this tool when you need to access and analyze the content of a web page, e.g. when the user asks you to read the 
contents of a webpage.
# @convert: TRUE
#
function (url, `_intent` = "") 
{
    btw_tool_web_read_url_impl(url = url)
}
<environment: 0x7faa305c2470>
~~~