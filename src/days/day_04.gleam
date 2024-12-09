import gleam/dict
import gleam/io
import gleam/list
import gleam/option
import gleam/string
import simplifile

pub fn part_one(input: String) -> Int {
  let matrix = parse(input)
  io.debug(matrix)
  dict.fold(matrix, 0, fn(count, point, _char) {
    count + find_xmases(matrix, point)
  })
}

type Point =
  #(Int, Int)

type Matrix =
  dict.Dict(Point, String)

fn parse(input: String) -> Matrix {
  let input_lines =
    input
    |> string.split("\n")
  let matrix =
    list.index_fold(input_lines, dict.new(), fn(matrix, line, current_row) {
      let cols = string.to_graphemes(line)
      list.index_fold(cols, matrix, fn(matrix, char, current_col) {
        dict.insert(matrix, #(current_row, current_col), char)
      })
    })
  io.debug(matrix)
  matrix
}

fn find_xmases(matrix: Matrix, at: Point) -> Int {
  let assert Ok(current_letter) = dict.get(matrix, at)
  case current_letter {
    "X" -> {
      let res = find_xmases_from(matrix, at)
      io.debug("res")
      io.debug(res)
      res
    }
    _ -> 0
  }
  //   find_xmases_from(matrix, at)
}

fn find_xmases_from(matrix: Matrix, at: Point) -> Int {
  list.fold(
    [
      #(-1, 0),
      #(-1, 1),
      #(0, 1),
      #(1, 1),
      #(1, 0),
      #(1, -1),
      #(0, -1),
      #(-1, -1),
    ],
    0,
    fn(accum: Int, vector: Point) {
      io.debug("trying at")
      io.debug(at)
      let letters = get_letters(matrix, at, vector, 3)
      io.debug(accum)
      io.debug(letters)
      case letters {
        Ok("MAS") -> {
          io.debug("IS OK")
          accum + 1
        }
        Ok(_) | Error(_) -> 0
      }
    },
  )
}

fn get_letters(
  matrix: Matrix,
  origin: Point,
  vector: Point,
  num_left: Int,
) -> Result(String, Nil) {
  case num_left > 0 {
    True -> {
      let new_point = #(origin.0 + vector.0, origin.1 + vector.1)
      case dict.get(matrix, new_point) {
        Ok(char) -> {
          case get_letters(matrix, new_point, vector, num_left - 1) {
            Ok(rest) -> Ok(char <> rest)
            Error(Nil) -> Error(Nil)
          }
        }
        Error(Nil) -> Error(Nil)
      }
    }
    False -> Ok("")
  }
}

// fn get_letter(
//   matrix: Matrix,
//   origin: Point,
//   vector: Point,
// ) -> Result(String, Nil) {
//   let #(x, y) = #(origin)
//   let #(xp, yp) = #(vector)
//   dict.get(matrix, #(x + xp, y + yp))
// }

pub fn input() -> String {
  let assert Ok(contents) = simplifile.read("./input/day_03.txt")
  contents
}
