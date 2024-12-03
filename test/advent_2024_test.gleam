import days/day_01
import days/day_02
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

pub fn day_one_test_input() -> String {
  "3   4
4   3
2   5
1   3
3   9
3   3"
}

pub fn day_one_part_one_test() {
  day_01.part_one(day_one_test_input())
  |> should.equal(11)
}

pub fn day_one_part_two_test() {
  day_01.part_two(day_one_test_input())
  |> should.equal(31)
}

pub fn day_two_test_input() -> String {
  "7 6 4 2 1
1 2 7 8 9
9 7 6 2 1
1 3 2 4 5
8 6 4 4 1
1 3 6 7 9"
}

pub fn day_two_part_one_test() {
  day_02.part_one(day_two_test_input())
  |> should.equal(2)
}

pub fn day_two_part_two_test() {
  day_02.part_two(day_two_test_input())
  |> should.equal(4)
}
