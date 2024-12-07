local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta

-- stylua: ignore
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
    fn {}() -> Result<(), Box<dyn std::error::Error>> {{
        {}
        Ok(())
    }}
    ]],
      {
        i(1, "test_name"), -- テスト名の初期値
        i(2, "todo!();") -- テストの実装部分の初期値
      }
    )
  ),
  s("tokiotest", fmt([[
    #[tokio::test]
    async fn {}() -> Result<(), Box<dyn std::error::Error>> {{
        {}
        Ok(())
    }}
    ]],
      {
        i(1, "test_name"), -- テスト名の初期値
        i(2, "todo!();") -- テストの実装部分の初期値
      }
    )
  ),
}
