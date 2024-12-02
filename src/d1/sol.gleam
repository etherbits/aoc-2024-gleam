import gleam/bool
import gleam/dict
import gleam/int
import gleam/io
import gleam/list
import gleam/option
import gleam/string
import utils/file

fn get_nums(lines: List(String), is_first: Bool) {
  list.map(lines, fn(x) {
    let num_res = case is_first {
      True -> list.first(string.split(x, "   "))
      False -> list.last(string.split(x, "   "))
    }

    let parsed_num_res =
      int.parse(case num_res {
        Ok(str) -> str
        Error(_) -> panic
      })

    case parsed_num_res {
      Ok(num) -> num
      Error(_) -> 0
    }
  })
}

pub fn p1() {
  let lines = file.get_lines("/inputs/d1/p1.txt")

  let l_nums = get_nums(lines, True) |> list.sort(int.compare)

  let r_nums = get_nums(lines, False) |> list.sort(int.compare)

  let assert Ok(diff) =
    list.reduce(
      list.map2(l_nums, r_nums, fn(a, b) { int.absolute_value(a - b) }),
      int.add,
    )

  io.println(int.to_string(diff))
}

pub fn p2() {
  let lines = file.get_lines("/inputs/d1/p2.txt")

  let l_nums = get_nums(lines, True)
  let r_nums = get_nums(lines, False)

  let mults =
    list.fold(r_nums, dict.new(), fn(mults, x) {
      dict.upsert(mults, x, fn(mult) {
        case mult {
          option.Some(m) -> m + 1
          option.None -> 1
        }
      })
    })

  let score =
    list.map(l_nums, fn(x) {
      case dict.get(mults, x) {
        Ok(mult) -> x * mult
        Error(_) -> 0
      }
    })
    |> list.reduce(int.add)

  case score {
    Ok(s) -> io.println(int.to_string(s))
    Error(_) -> io.println("invalid score")
  }
}
