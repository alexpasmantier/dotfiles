((log_level) @comment.documentation
(#eq? @comment.documentation "TRACE"))

((log_level) @comment.note
(#eq? @comment.note "DEBUG"))

((log_level) @comment.todo
(#eq? @comment.todo "INFO"))

((log_level) @comment.warning
(#eq? @comment.warning "WARN"))

((log_level) @comment.error
(#eq? @comment.error "ERROR"))

((log_level) @label
(#eq? @label "FATAL"))

(timestamp) @property
(file_path) @type
(line_number) @keyword
(message) @string
