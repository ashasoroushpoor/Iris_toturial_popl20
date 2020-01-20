# The Iris tutorial @ POPL'20

This tutorial comes in two versions:

- The folder `exercises`: skeletons of the exercises with solutions left out.
- The folder `solutions`: the exercises together with their solutions.

## Dependencies

For the tutorial material you need to have the following dependencies installed:

- Coq 8.8.2 / 8.9.1 / 8.10.1
- A development version of [Iris](https://gitlab.mpi-sws.org/iris/iris)

*Note:* the tutorial material will not work with earlier versions of Iris, it
is important to install the exact versions as given above.

## Installing Iris via opam

The easiest, and recommend, way of installing Iris and its dependencies is via
the OCaml package manager opam (2.0.0 or newer). You first have to add the Coq
opam repository and the Iris development repository (if you have not already
done so earlier):

    opam repo add coq-released https://coq.inria.fr/opam/released
    opam repo add iris-dev https://gitlab.mpi-sws.org/iris/opam.git

Then you can do `make build-dep` to install exactly the right version of Iris.

## Compiling the exercises

Run `make` to compile the exercises.

## Overview

Introduction to Iris and the HeapLang language:

- [language.v](solutions/language.v): An introduction to Iris's HeapLang
  language, program specifications using weakest preconditions, and proofs of
  these specifications using Iris's tactics for separation logic.
- [polymorphism.v](solutions/polymorphism.v): The encoding of polymorphic
  functions and existential packages in HeapLang.

Syntactic typing:

- [types.v](solutions/types.v): The definition of syntactic types and the
  type-level substitution function.
- [typed.v](solutions/typed.v): The syntactic typing judgment.

Semantic typing:

- [sem_types.v](solutions/sem_types.v): The model of semantic types in Iris.
- [sem_typed.v](solutions/sem_typed.v): The definition of the semantic typing
  judgment in Iris.
- [sem_type_formers.v](solutions/sem_type_formers.v): The definition of the
  semantic counterparts of the type formers (like products, sums, functions,
  references, etc.).
- [sem_operators.v](solutions/sem_operators.v): The judgment for semantic
  operator typing and proofs of the corresponding semantic rules.
- [compatibility.v](solutions/compatibility.v): The semantic typing rules, i.e.,
  the compatibility lemmas.
- [interp.v](solutions/interp.v): The interpretation of syntactic types in terms
  of semantic types.
- [fundamental.v](solutions/fundamental.v): The *fundamental theorem**, which
  states that any syntactically typed program is semantically typed..
- [safety.v](solutions/safety.v): Proofs of semantic and syntactic type safety.
- [unsafe.v](solutions/unsafe.v): Proofs of "unsafe" programs, i.e. programs
  that are not syntactically typed, but can be proved to be semantically safe.
- [parametricity.v](solutions/parametricity.v): The use of the semantic typing
  for proving parametricity results.

Ghost theory for semantic safety of "unsafe" programs:

- [two_state_ghost.v](solutions/two_state_ghost.v): The ghost theory for a
  transition system with two states.
- [symbol_ghost.v](solutions/symbol_ghost.v): The ghost theory for the symbol
  ADT example.

Other:

- [demo.v](solutions/demo.v): A simplified version of the development to the
  simplified case, as shown during the lecture at the POPL'20 tutorial.
  
## Documentation

The files [`proof_mode.md`] and [`heap_lang.md`] in the Iris repository contain a
list of the Iris Proof Mode tactics as well as the specialized tactics for
reasoning about HeapLang programs.

[`proof_mode.md`]: https://gitlab.mpi-sws.org/iris/iris/blob/master/docs/proof_mode.md
[`heap_lang.md`]: https://gitlab.mpi-sws.org/iris/iris/blob/master/docs/heap_lang.md

If you would like to know more about Iris, we recommend to take a look at:

- http://iris-project.org/tutorial-material.html
  Lecture Notes on Iris: Higher-Order Concurrent Separation Logic
  Lars Birkedal and Aleš Bizjak
  Used for an MSc course on concurrent separation logic at Aarhus University
- https://www.mpi-sws.org/~dreyer/papers/iris-ground-up/paper.pdf
  Iris from the Ground Up: A Modular Foundation for Higher-Order Concurrent
  Separation Logic
  Ralf Jung, Robbert Krebbers, Jacques-Henri Jourdan, Aleš Bizjak, Lars
  Birkedal, Derek Dreyer.
  A detailed description of the Iris logic and its model
