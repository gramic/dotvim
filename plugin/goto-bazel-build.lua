local function find_in_bazel_build()
  local fileName = vim.fn.expand("%:t")
  print("my file is " .. fileName)
  vim.cmd("vsplit | e BUILD")
  vim.cmd("/" .. fileName)
end

return {
  run = find_in_bazel_build
}
