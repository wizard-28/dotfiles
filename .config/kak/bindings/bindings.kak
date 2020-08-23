# Tab completion
hook global InsertCompletionShow .* %{
     try %{
         exec -draft 'h<a-K>\h<ret>'
         map window insert <s-tab> <c-p>
         map window insert <tab> <c-n>
     }
}
hook global InsertCompletionHide .* %{
     unmap window insert <tab> <c-n>
     unmap window insert <s-tab> <c-p>
}
