import argv
import d1/sol.{p1, p2}
import gleam/io

pub fn main() {
  case argv.load().arguments {
    ["1", "1"] -> {
      let _ = p1()
      Nil
    }
    ["1", "2"] -> {
      let _ = p2()
      Nil
    }
    _ -> {
      io.println("usage: gleam run {day} {part}")
      Nil
    }
  }
}
