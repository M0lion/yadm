; extends

; JSX elements as a textobject: `ax` / `ix`
(jsx_element) @jsx.outer

(jsx_self_closing_element) @jsx.outer

; inner = everything between the opening and closing tag
; (a fragment `<>...</>` is also a jsx_element, with empty tags)
(jsx_element
  (jsx_opening_element)
  .
  (_)+ @jsx.inner
  .
  (jsx_closing_element))

; self-closing has no children, so inner = the tag name + attributes
(jsx_self_closing_element
  (_)+ @jsx.inner)
