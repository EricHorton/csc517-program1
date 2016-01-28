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

  # Index Page
  root 'index#index'

  # Users
  get '/users/:id/edit' => 'users#edit', as: 'edit_user'
  put '/users/:id' => 'users#update', as: 'user'
  get 'create_student' => 'students#new', as: 'students'
  post 'create_student' => 'students#create', as: 'create_student'

  # Authentication
  get 'login' => 'authentication#new'
  post 'login' => 'authentication#create'
  delete 'logout' => 'authentication#destroy'

  # Courses
  get '/courses' => 'courses#index'
  get '/courses/my' => 'courses#my', as: 'my_courses'
  get '/courses/:id' => 'courses#show', as: 'course'

  # Enrollment Requests
  post '/courses/:course_id/students/:student_id/enrollment' => 'enrollment#create', as: 'enrollment'

  # Course History
  delete '/histories/:id' => 'history#destroy', as: 'destroy_history'
end
