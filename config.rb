###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

# With alternative layout
# page "/path/to/file.html", layout: :otherlayout

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", locals: {
#  which_fake_page: "Rendering a fake page with a local variable" }

# General configuration

activate :external_pipeline,
  name:    :gulp,
  command: build? ? "./node_modules/gulp/bin/gulp.js default" : "./node_modules/gulp/bin/gulp.js watch",
  source:  ".tmp"

import_path File.expand_path("bower_components", app.root)

###
# Helpers
###

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     "Helping"
#   end
# end

helpers do
  def navbar_link_class(path)
    current_page_path_array = current_page.path.chomp(File.extname(current_page.path)).split("/")
    link_path_array         = path.chomp(File.extname(path)).split("/")

    current_page_path_array.delete("index")
    link_path_array.delete("index")

    (current_page_path_array & link_path_array).empty? ? { class: "c-navbar__link" } : { class: "c-navbar__link c-navbar__link--active" }
  end

  def image_with_srcset_tag(source, srcset = {}, options = {})
    srcset = srcset.map { |src, size| "#{asset_path(:images, src)} #{size}" }.join(", ")
    image_tag(source, options.merge(srcset: srcset))
  end
end

# Build-specific configuration
configure :build do
  # Minify CSS on build
  # activate :minify_css

  # Minify Javascript on build
  # activate :minify_javascript
end
