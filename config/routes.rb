Rails.application.routes.draw do

  devise_for :users

  root to: "home#index"

  mount API::Base, at: "/"
  mount GrapeSwaggerRails::Engine, at: "/documentation"

end
