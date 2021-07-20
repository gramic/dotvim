local function find_in_bazel_build()
  local fileName = vim.fn.expand("%:t")
  print("my file is " .. fileName)
  vim.cmd("split | e %:h/BUILD*")
  vim.cmd("/" .. fileName)
end

return {
  find_in_bazel_build = find_in_bazel_build
}
