(lang dune 3.2)

(name bowling)

(generate_opam_files true)

(source
 (github beltsmith/bowlml))

(authors "Alex Girdler")

(maintainers "Alex Girdler")

(license MIT)

(documentation https://url/to/documentation)

(package
 (name bowling)
 (synopsis "A short synopsis")
 (description "A longer description")
 (depends ocaml dune pps ppx_deriving ppx_expect ppx_inline_test)
 (tags
  (topics "to describe" your project)))

; See the complete stanza docs at https://dune.readthedocs.io/en/stable/dune-files.html#dune-project
