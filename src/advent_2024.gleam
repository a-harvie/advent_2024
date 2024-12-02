import days/day_01
import gleam/io

pub fn main() {
  io.debug(day_01.part_one(day_01.input()))
  io.debug(day_01.part_two(day_01.input()))
}
