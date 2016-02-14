Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # Run `rake routes` to list all generated routes

  # Index Page
  root 'index#index'

  # Users
  resources :users, only: [:edit, :update] do
    # Passwords
    member do
      get 'password' => 'users#edit_password'
      put 'password' => 'users#update_password'
    end
  end

  # Students
  resources :students, only: [:new, :create]

  # Authentication - Non RESTful
  get 'login' => 'authentication#new'
  post 'login' => 'authentication#create'
  delete 'logout' => 'authentication#destroy'

  # Courses
  resources :courses, only: [:index, :show] do
    # Enrollment requests
    resources :students, only: [] do
      member do
        post 'enrollment' => 'enrollment#create'
      end
    end

    # List student courses
    collection do
      get 'my' => 'courses#my', as: 'my'
    end
  end

  get 'enrollment' => 'enrollment#index'
  put 'enrollment' => 'enrollment#update'


  # Course History
  #resources :history, only: [:index]
  get 'history' => 'history#index'
  get 'history/:id'=> 'history#show'
  post 'history' => 'history#create'
  delete 'history' => 'history#destroy'

  #get 'grade' => 'grade#index'

  resources :grade, only: [:new, :create, :index]


  resources :course_material, only: [:new, :create, :index]

  # Messages
  resources :messages, only: [:index, :show] do
    resources :posts, only: [:new, :create]
  end

  resources :users, only: [] do
    resources :messages, only: [:new, :create]
  end

  get 'course_inactive' => 'courses#course_inactive'

end
