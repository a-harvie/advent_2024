import gleam/int

import gleam/list
import gleam/string
import simplifile

pub fn part_one(input: String) -> Int {
  let input_lists = parse_input(input)

  list.count(input_lists, is_safe)
}

pub fn part_two(input: String) -> Int {
  let input_lists = parse_input(input)

  list.count(input_lists, fn(report: List(Int)) {
    is_safe(report) || make_safe(report)
  })
}

type ReportStatus {
  ReportStatus(diff: Int, increasing: Bool)
}

fn is_safe(report: List(Int)) -> Bool {
  let statuses =
    list.window_by_2(report)
    |> list.map(fn(w) {
      // we probably don't need this - we could just pipe the diff to the all functions and do the comparison
      // to zero directly, but this is more readable?
      ReportStatus(diff: w.0 - w.1, increasing: w.0 - w.1 < 0)
    })

  list.all(statuses, fn(s) { diff_ok(s.diff) && s.increasing })
  || list.all(statuses, fn(s) { diff_ok(s.diff) && !s.increasing })
}

// make_safe: brute force go brr
fn make_safe(report: List(Int)) -> Bool {
  report
  |> list.combinations(list.length(report) - 1)
  |> list.any(is_safe)
}

fn diff_ok(diff: Int) -> Bool {
  let ab = int.absolute_value(diff)
  ab >= 1 && ab <= 3
}

// parse_input takes the input string and returns a list containing each line as a list of ints
fn parse_input(input: String) -> List(List(Int)) {
  input
  |> string.split("\n")
  |> list.map(fn(l) { string.split(l, " ") })
  |> list.map(fn(l) { list.filter(l, fn(s) { !string.is_empty(s) }) })
  |> list.map(fn(l) {
    list.map(l, fn(s) {
      let assert Ok(i) = int.parse(s)
      i
    })
  })
}

pub fn input() -> String {
  let assert Ok(contents) = simplifile.read("./input/day_02.txt")
  contents
}
