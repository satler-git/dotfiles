local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta

-- stylua: ignore
return {
  s(
    "modtests",
    fmta([[
    #[cfg(test)]
    mod tests {
      <>
    }
    ]],
      {
        i(1)
      }
    )
  ),
  s("test", fmt([[
    #[test]
    fn []() -> Result<(), Box<dyn std::error::Error>> {
      []
      Ok(())
    }
    ]],
      {
        i(1, "name"),
        i(2, "ErrorType"),
        i(3, "todo!();")
      },
    { delimiters = "[]" }
    )
  ),
}
