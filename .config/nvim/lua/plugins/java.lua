return {
  {
    "mfussenegger/nvim-jdtls",
    opts = function(_, opts)
      local java_home = vim.fn.trim(vim.fn.system({ "/usr/libexec/java_home", "-v", "21+" }))
      if vim.v.shell_error == 0 and vim.fn.executable(java_home .. "/bin/java") == 1 then
        table.insert(opts.cmd, "--java-executable=" .. java_home .. "/bin/java")
        opts.jdtls = opts.jdtls or {}
        opts.jdtls.cmd_env = vim.tbl_extend("force", opts.jdtls.cmd_env or {}, {
          JAVA_HOME = java_home,
        })
      else
        vim.notify("JDTLS requires a Java 21+ runtime", vim.log.levels.ERROR)
      end

      -- Mason's java-test bundle is incompatible with the installed JDTLS snapshot
      -- and prevents the language server from advertising its core capabilities.
      opts.test = false

      local default_full_cmd = opts.full_cmd
      opts.full_cmd = function(config)
        local root_dir = config.root_dir(vim.api.nvim_buf_get_name(0))
        local pom = root_dir and root_dir .. "/pom.xml"
        local classpath = root_dir and root_dir .. "/.classpath"
        local pom_stat = pom and vim.uv.fs_stat(pom)
        local classpath_stat = classpath and vim.uv.fs_stat(classpath)

        if pom_stat and (not classpath_stat or pom_stat.mtime.sec > classpath_stat.mtime.sec) then
          local result = vim
            .system({ "mvn", "-q", "eclipse:eclipse" }, {
              cwd = root_dir,
              env = vim.tbl_extend("force", vim.fn.environ(), { JAVA_HOME = java_home }),
            })
            :wait()
          if result.code ~= 0 then
            vim.notify("JDTLS could not generate Maven Eclipse metadata: " .. result.stderr, vim.log.levels.ERROR)
          end
        end

        return default_full_cmd(config)
      end
    end,
  },
}
