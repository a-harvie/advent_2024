import gleam/int

// import gleam/io
import gleam/list
import gleam/option
import gleam/regexp
import simplifile

pub fn part_one(input: String) -> Int {
  let pairs = parse_input(input)
  //   io.debug(pairs)
  list.map_fold(pairs, 0, fn(accumulator, factors) {
    #(accumulator + factors.0 * factors.1, factors)
  }).0
}

pub fn part_two(input: String) -> Int {
  let pairs = parse_enabled_muls(input)
  //   io.debug(pairs)
  list.map_fold(pairs, 0, fn(accumulator, factors) {
    #(accumulator + factors.0 * factors.1, factors)
  }).0
}

fn parse_input(input: String) -> List(#(Int, Int)) {
  // NB day 3 specifies "where X and Y are each 1-3 digit numbers" - this may change?
  let assert Ok(re) =
    regexp.compile(
      "mul\\(([0-9]{1,3}),([0-9]{1,3})\\)",
      with: regexp.Options(case_insensitive: False, multi_line: True),
    )
  regexp.scan(re, input)
  |> list.map(extract_submatches)
  |> list.map(parse_mul)
}

fn extract_submatches(match: regexp.Match) -> List(String) {
  option.values(match.submatches)
}

fn parse_enabled_muls(input: String) -> List(#(Int, Int)) {
  let assert Ok(re) =
    regexp.compile(
      "(do|don't|mul)\\(([0-9]{1,3})?,?([0-9]{1,3})?\\)",
      with: regexp.Options(case_insensitive: False, multi_line: True),
    )
  let scan = regexp.scan(re, input)
  let ops = parse_ops(scan)
  //   io.debug(ops)
  enabled_muls(ops)
}

type Op {
  Op(cmd: String, args: List(String))
}

fn parse_ops(matches: List(regexp.Match)) -> List(Op) {
  list.map(matches, fn(match: regexp.Match) {
    let vals = option.values(match.submatches)
    let assert Ok(cmd) = list.first(vals)
    let assert Ok(args) = list.rest(vals)
    Op(cmd: cmd, args: args)
  })
}

fn enabled_muls(ops: List(Op)) -> List(#(Int, Int)) {
  enabled_muls_loop(ops, True, list.new())
}

fn enabled_muls_loop(
  ops: List(Op),
  enable_mul: Bool,
  enabled_muls: List(#(Int, Int)),
) -> List(#(Int, Int)) {
  case ops {
    [first, ..rest] ->
      enabled_muls_loop(
        rest,
        parse_enabled(first, enable_mul),
        add_mul(first, enable_mul, enabled_muls),
      )
    [] -> enabled_muls
  }
}

fn parse_enabled(op: Op, enable_mul: Bool) -> Bool {
  case op.cmd {
    "do" -> True
    "don't" -> False
    _ -> enable_mul
  }
}

fn add_mul(
  op: Op,
  enable_mul: Bool,
  enabled_muls: List(#(Int, Int)),
) -> List(#(Int, Int)) {
  case op.cmd {
    "mul" -> {
      case enable_mul {
        True -> {
          let assert Ok(first) = list.first(op.args)
          let assert Ok(second) = op.args |> list.drop(1) |> list.first
          let assert Ok(a) = int.parse(first)
          let assert Ok(b) = int.parse(second)
          list.append(enabled_muls, [#(a, b)])
        }
        False -> enabled_muls
      }
    }
    _ -> enabled_muls
  }
}

fn parse_mul(input: List(String)) -> #(Int, Int) {
  let assert Ok(first) = input |> list.first
  let assert Ok(second) = input |> list.drop(1) |> list.first
  let assert Ok(num_a) = int.parse(first)
  let assert Ok(num_b) = int.parse(second)
  #(num_a, num_b)
}

pub fn input() -> String {
  let assert Ok(contents) = simplifile.read("./input/day_03.txt")
  contents
}
