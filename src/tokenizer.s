int
main
(
)
{
puts
(
"Hello world"
)
;
}
-------------------------------------
reader
readChar
	lda isCharPushedBack
	cmp #1
	beq usePushBackChar
	


isCharPushedBack	db	0
pushBackChar		db	0
	


-------------------------------------
tokenizer
	jsr skipWhitespace
	jsr nextChar
	cmp #"("
	beq prepSingleCharToken
	cmp #")"
	beq prepSingleCharToken

prepSingleCharToken
	sta token
	lda #0
	sta token+1

endTokenizer
	rts

token	db	256

