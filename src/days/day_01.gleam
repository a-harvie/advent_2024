import gleam/int

// import gleam/io
import gleam/list
import gleam/string
import simplifile

pub fn main() {
  part_one(input())
  part_two(input())
}

pub fn part_one(input: String) -> Int {
  let input_tuples = input_tuples(input)
  // io.debug(input_list)
  list.fold(input_tuples, 0, fn(accumulator, inputs) {
    accumulator + int.absolute_value(inputs.0 - inputs.1)
  })
}

pub fn part_two(input: String) -> Int {
  let input_lists = input_lists(input)
  // io.debug(input_lists)
  list.fold(input_lists.0, 0, fn(accumulator, a) {
    accumulator + a * list.count(input_lists.1, fn(b) { a == b })
  })
}

fn input_tuples(input: String) -> List(#(Int, Int)) {
  let input_lists = input_lists(input)
  list.zip(input_lists.0, input_lists.1)
}

fn input_lists(input: String) -> #(List(Int), List(Int)) {
  // ref: [["3", "4"], ["4", "3"], ["2", "5"], ["1", "3"], ["3", "9"], ["3", "3"]]
  let parsed_input = parse_input(input)

  // TODO: this can be done more cleanly either recursively slicing the first elements off the sub-lists
  // or with fold?
  let first_items =
    list.map(parsed_input, fn(l) {
      let assert Ok(first) = list.first(l)
      first
    })
    |> list.sort(int.compare)
  // io.debug(first_items)

  // Another way to assert:
  // let assert Ok(first_items_2) = list.try_map(parsed_input, list.first)
  // io.debug(first_items_2)

  let second_items =
    list.map(parsed_input, fn(l) {
      let assert Ok(last) = list.last(l)
      last
    })
    |> list.sort(int.compare)
  // io.debug(second_items)

  #(first_items, second_items)
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
