import days/day_01
import days/day_02
import days/day_03
import gleam/int
import gleam/io

pub fn main() {
  io.println("Day 01")
  output(day_01.part_one(day_01.input()))
  output(day_01.part_two(day_01.input()))

  io.println("Day 02")
  output(day_02.part_one(day_02.input()))
  output(day_02.part_two(day_02.input()))

  io.println("Day 03")
  output(day_03.part_one(day_03.input()))
  output(day_03.part_two(day_03.input()))
}

fn output(answer: Int) {
  io.println(int.to_string(answer))
}
