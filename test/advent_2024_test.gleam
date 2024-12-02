import days/day_01
import gleeunit
import gleeunit/should

pub fn main() {
  gleeunit.main()
}

// gleeunit test functions end in `_test`
pub fn hello_world_test() {
  1
  |> should.equal(1)
}

pub fn day_one_part_one_test() {
  let day_one_test_input =
    "3   4
4   3
2   5
1   3
3   9
3   3"

  day_01.part_one(day_one_test_input)
  |> should.equal(11)
}