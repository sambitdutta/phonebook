# Be sure to restart your server when you modify this file.
# config/initializers/assets.rb
# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path
Rails.application.config.assets.paths.unshift Rails.root.join('node_modules')

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )

# each file from app/assets/javascripts and app/assets/stylesheets
folders = %w[javascripts stylesheets fonts]
precompiles = folders.flat_map do |folder|
  Dir[Rails.root.join("app/assets/#{folder}/**/*.*")].map do |path|
    Pathname.new(path).relative_path_from(Rails.root.join('app', 'assets', folder)).to_s
  end
end
precompiles.uniq!
precompiles.compact!
# add files to precompile
Rails.application.config.assets.precompile += precompiles
