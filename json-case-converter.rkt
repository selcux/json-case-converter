#! /usr/bin/env racket

#lang racket

(require casemate)
(require racket/cmdline)
(require json)
(require racket/pretty)

(define out-format (make-parameter "snake"))

(define (convert input)
  (match (out-format)
    ["snake" (->snake_case input)]
    ["pascal" (->PascalCase input)]
    ["camel" (->camelCase input)]
    ["kebab" (->kebab-case input)]
    [_ (raise "Unknown format!")]))

(define (traverse input)
  (match input
    [(hash-table (k v) ...)
     (define ht (make-hasheq))
      (for ([x k]
           [y v])
       (hash-set! ht (convert x) (traverse y)))
      ht]
    [(list x ...)
     (for/list ([item input])
       (traverse item))]
    [_ input]))

(define (run filename)
  (let ([jsn (call-with-input-file filename read-json)])
    (write-json (traverse jsn))))
 
(define json-case-converter
  (command-line
   #:program "case-converter"
   #:once-each
   [("-f" "--format") of
                      "Output format: snake | pascal | camel | kebab"
                      (or (empty? of) (out-format of))]
   #:args (filename)
   (run filename)))
