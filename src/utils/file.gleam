import gleam/string
import simplifile

pub fn get_lines(rel_path: String) {
  let assert Ok(dir) = simplifile.current_directory()
  let assert Ok(txt) = simplifile.read(dir <> rel_path)

  string.split(txt, "\n")
}
