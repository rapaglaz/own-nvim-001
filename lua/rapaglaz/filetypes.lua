vim.filetype.add({
  extension = {
    templ    = "templ",
    mdx      = "mdx",
    astro    = "astro",
    -- astro-markdown is tailwindcss's name for .astro files containing markdown
    ["astro-markdown"] = "astro",
    hbs      = "handlebars",
    mustache = "mustache",
    njk      = "nunjucks",
    twig     = "twig",
    ejs      = "ejs",
    jq       = "jq",
  },
  filename = {
    ["docker-compose.yml"]  = "yaml.docker-compose",
    ["docker-compose.yaml"] = "yaml.docker-compose",
    ["compose.yml"]         = "yaml.docker-compose",
    ["compose.yaml"]        = "yaml.docker-compose",
    ["go.sum"]              = "gosum",
  },
  pattern = {
    [".*%.gohtml"]               = "gotmpl",
    [".*%.gotmpl"]               = "gotmpl",
    ["go%.work"]                 = "gowork",
    [".*/templates/.*%.ya?ml"]   = "yaml.helm-values",
    [".*/templates/.*%.tpl"]     = "yaml.helm-values",
    [".*%.gitlab%-ci.*%.ya?ml"]  = "yaml.gitlab",
    [".*%.html"]                 = function(_, _, _)
      -- detect Django templates by {% or {{ markers
      local first = vim.fn.getline(1) .. vim.fn.getline(2) .. vim.fn.getline(3)
      if first:match("{%%") or first:match("{{") then
        return "htmldjango"
      end
    end,
  },
})
