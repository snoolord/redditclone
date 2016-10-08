Rails.application.routes.draw do


  resources :users
  resource :session, only:[:new, :destroy, :create]

  resources :subs do
    resources :post, except:[:index]
  end

end
