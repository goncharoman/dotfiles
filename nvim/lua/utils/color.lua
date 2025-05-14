return {
  ---Get highlight colour
  ---@param hlgroup string highlight name
  ---@param attr string hl attr (like 'bg' or 'fg')
  ---@return string
  hlcolor = function(hlgroup, attr)
    return vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID(hlgroup)), attr .. "#")
  end,
  ---Get normalised colour
  ---@param color string colour like 'pink' or '#fa8072'
  ---@return string[]
  normcolor = function(color)
    local color = vim.api.nvim_get_color_by_name(color)
    local byte = function(value, offset)
      return bit.band(bit.rshift(value, offset), 0xFF)
    end
    return { byte(color, 16), byte(color, 8), byte(color, 0) }
  end,
  ---Set highlight
  ---@param hlgroup string highlight name
  ---@param def table highlight def
  hlset = function(hlgroup, def)
    vim.api.nvim_set_hl(0, hlgroup, def)
  end,
  ---Extand highlight
  ---@param hlgroup string highlight name
  ---@param def table new highlight def
  extand = function(hlgroup, def)
    local current = vim.api.nvim_get_hl_by_name(hlgroup, true)
    return vim.tbl_extend("force", {}, current, def)
  end,
  ---Bland color
  ---@param bg string background color
  ---@param fg string background color
  ---@param alpha number alpha
  ---@return string
  blend = function(fg, bg, alpha)
    local nfg = LazyVim.color.normcolor(fg)
    local nbg = LazyVim.color.normcolor(bg)
    local channel = function(i)
      local ret = (alpha * nfg[i] + ((1 - alpha) * nbg[i]))
      return math.floor(math.min(math.max(0, ret), 255) + 0.5)
    end
    return string.format("#%02X%02X%02X", channel(1), channel(2), channel(3))
  end,
  ---Create transparency hl
  ---@param hlgroup string highlight group name
  ---@param alpha number alpha
  ---@return table
  trans = function(hlgroup, alpha)
    local currbg = LazyVim.color.hlcolor("Normal", "bg")
    return LazyVim.color.extand(hlgroup, {
      bg = LazyVim.color.blend(LazyVim.color.hlcolor(hlgroup, "bg"), currbg, alpha),
      fg = LazyVim.color.blend(LazyVim.color.hlcolor(hlgroup, "fg"), currbg, alpha),
    })
  end,
}
