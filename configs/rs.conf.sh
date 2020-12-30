#!/bin/bash
export RUSTUP_HOME="${HOME}/.config/.rustup"
export CARGO_HOME="${HOME}/.config/.cargo"
export PATH="${CARGO_HOME}/bin:$PATH"

# quickly open rust documentation in browser
alias rsdoc="rustup doc --std"

# quicky compile and run rust program (provide root of program)
rsrun() {
  rustc $1.rs && ./$1
}
