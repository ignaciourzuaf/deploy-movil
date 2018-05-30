Rails.application.routes.draw do
  resources :annotations
  resources :additional_subjects
  resources :categories
  resources :severities
  resources :types
  resources :cycles
  delete 'cycles/:cycle_id/levels/:id' => 'cycle_levels#destroy'

  delete 'annotations/:annotation_id/students/:id' =>
    'annotated_students#destroy'

  get 'annotations_movil' => 'annotations#new_index'
  # For details on the DSL available within this file,
  # see http://guides.rubyonrails.org/routing.html
end
