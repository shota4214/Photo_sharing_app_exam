Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  root 'users#new'
  resources :favorites, only:[:create, :destroy, :index]
  resources :sessions, only:[:new, :create, :destroy]
  resources :users, only:[:new, :create, :show, :update, :edit] do
    collection do
      post :confirm
    end
  end
  resources :pictures do
    collection do
      post :confirm
    end
  end
end
