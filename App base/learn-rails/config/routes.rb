Rails.application.routes.draw do
 root 'homepages#show'
 resource :homepage  , only: [:show] do #, as: :home do 
    collection do
      get 'apps'
      get 'contacts'
    end
  end

  get 'home/apps/*any', to: 'homepages#show'
  
#  get 'apps' => 'homes#apps' 
#  get '/contacts' => 'homes#contacts'
#  get '/test' => 'homes#test'


# get 'acronyms/app', to: 'acronyms#app'
# get 'imagefinder/app', to: 'imagefinder#app'
# get 'blackjack/app', to: 'blackjack#app'

namespace :apps do
 get 'acronyms/app'=> 'acronyms#app' 
 get 'imagefinder/app'=> 'imagefinder#app' 
 get 'blackjack/app' => 'blackjack#app'
end
 

  

end
