Flixter::Application.routes.draw do
  devise_for :users
  # Singleton route (no id passed):
  resource :dashboard, :only => [:show]
  root 'static_pages#index'
  resources :courses, :only => [:index, :show] do
    resources :enrollments, :only => :create
  end
  resources :lessons, :only => [:show]
  namespace :instructor do
    # Set up a sections route without any actions solely to nest lessons underneath it, to avoid lessons being underneath a course id in the URL.  This is so that a user cannot manually go to the new lesson form for the wrong course.
    resources :lessons, :only => [:update]
    resources :sections, :only => [:update] do
      resources :lessons, :only => [:new, :create]
    end
    resources :courses, :only => [:new, :create, :show] do
      resources :sections, :only => [:create]
    end
  end
end
