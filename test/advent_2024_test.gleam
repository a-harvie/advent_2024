import days/day_01
import days/day_02
import days/day_03
import days/day_04
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

pub fn day_three_part_one_test_input() -> String {
  "xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))"
}

pub fn day_three_part_one_test() {
  day_03.part_one(day_three_part_one_test_input())
  |> should.equal(161)
}

pub fn day_three_part_two_test_input() -> String {
  "xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))"
}

pub fn day_three_part_two_test() {
  day_03.part_two(day_three_part_two_test_input())
  |> should.equal(48)
}

pub fn day_four_test_input() -> String {
  "MMMSXXMASM
MSAMXMSMSA
AMXSXMAAMM
MSAMASMSMX
XMASAMXAMM
XXAMMXXAMA
SMSMSASXSS
SAXAMASAAA
MAMMMXMMMM
MXMXAXMASX"
}

pub fn day_four_part_one_test() {
  day_04.part_one(day_four_test_input())
  |> should.equal(18)
}
