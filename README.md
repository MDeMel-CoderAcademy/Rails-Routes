# Rails session 2 - Routes.

In session 1 we worked on a Rails website that gave us a glimpse as to the underlying mechanisms of the Rails Framework.

In this session we will study ' Routes ' and ' Routing ' in more depth and in context with Rails conventions. It is important to learn about Routing before moving forward with any other Rails concept since routing happens to be the first process that takes place when a user is trying to access your website through a web request (HTTP request).

We will be practicing and iterating on top of the last session's application to better enforce the concepts being introduced in this session.</br> But before moving any further let's take a deep dive into HTTP requests.

- [Rails session 2 - Routes.](#rails-session-2---routes)
  - [What are HTTP requests ?](#what-are-http-requests-)
  - [What are Routes ?](#what-are-routes-)
  - [How do we define a Route ?](#how-do-we-define-a-route-)
    - [Resource routing  ' the Rails Default '](#resource-routing---the-rails-default-)
      - [Restricting the Routes created.](#restricting-the-routes-created)
      - [Adding more actions to resourceful routes](#adding-more-actions-to-resourceful-routes)
      - [More ways to Customize resourceful routes.](#more-ways-to-customize-resourceful-routes)
    - [Non-Resourceful routes](#non-resourceful-routes)
      - [Syntax for defining a Non-Resourceful route.](#syntax-for-defining-a-non-resourceful-route)
      - [Matching Routes to HTTP methods](#matching-routes-to-http-methods)
  - [Naming Routes](#naming-routes)
  - [Route Globbing and Wildcard segments.](#route-globbing-and-wildcard-segments)
  - [Redirecting requests](#redirecting-requests)
  - [Controller Namespacing](#controller-namespacing)

## What are HTTP requests ?

HTTP stands for 'Hyper Text Transfer Protocol' and was initiated by sir Timothy John Berners-Lee who is also the founder of the world wide web.

So basically when your browser and ultimately your computer encode's the data/request you wish to send out to the web as a digital entity - HTTP is the standard followed worldwide in every computer.

Like most western countries mostly use ' English ' to communicate. All computers on the internet use 'HTTP' as the standard means of communication.
</br>
![http base](http1.png)

Whenever someone accesses a web site on the Internet, two computers communicate. One computer has a software program known as a browser, the other computer has a software program known as a web server. 
The browser sends a request to the server  and the server sends a response to the browser. 
The request contains the URI ( or ' site path ' ) that is being requested  and information about the browser that is making the request.
The response contains the data that was requested (if it is available), information about the page, and information about the server. (visit this [link](https://www.aisangam.com/blog/http-request-message-format-well-explained/) for an extended look at HTTP requests and methods)


Both HTTP requests and responses have identical data structures albeit with different types of information.

**The request format**</br>
a. The first line contains the type of request, the name of the requested page and the protocol that is being used. </br>
b. Subsequent lines are the request headers. They contain information about the browser and the request.</br>
c. A blank line in the request indicates the end of the request headers</br>
d. In a POST request, additional information can be included after the blank line

**The response format**</br>
a. The first line contains the protocol being used, the status code and a brief description of the status.</br>
b. Subsequent lines are the response headers. They contain information about the server and the response. </br>
c. A blank line in the response indicates the end of the response headers.</br>
d. In a successful response, the content of the page will be sent after the blank line.</br>

Let's take an extended look at what the HTTP [Request Headers] contain,</br>

![http base](http21.png)
![http base](http22.png)

The content type header (in http response headers) is what tells your browser the type of content that is being carried in the response. These content types are expressed as Multipurpose Internet Mail Extensions [MIME] types

The basic structure of a MIME type is a general type and a subtype (type/subtype), the general type for text has several specific types, for plain text, HTML text and style sheet text. These types are represented as text/plain, text/html and text/css, respectively

The most common content type on the web is HTML text, represented as the MIME type text/html.</br> These MIME Types are important moving forward with ' Controllers ' and ' Views '.

## What are Routes ?

Routing is the process of handling a user request or more specifically defining how your web application's router handles a ' HTTP ' request. A Route is one such definition and a collection of ' Routes ' will define how your web application responds to user requests.

Routes are defined using a HTTP verb (http methods ; get , post , update...etc.) and a path pattern. (/mypath/subpath/...)

## How do we define a Route ?

All our defined routes will go in the **config/routes.rb** file.

**The order in which we define a route is very important!**

**The more important or the more regularly accessed routes such as your 'root path ' should be placed at the very top of the file.**

In Rails there are 2 main ways of defining a route

- Resource routing which is the recommended Rails default
- Non-Resourceful routes which are also called 'named' routes.

### Resource routing  ' the Rails Default '

Resource routing provides you the choice of defining your routes in two ways. Using either of **resources** or **resource** keyword. 

Rails adapted RESTful design as a convention in Rails 1.2 onward. The REST principle is based on working with information in the form of resources. Each piece of information is dealt with as a resource, each resource has a unique interaction point for every action that can be performed on it, and each interaction point (action) is normally represented using a URL and a request method.

```ruby
resources :pages
```

Adding the above line of code to your routes file creates the following 7 routes.

| HTTP Verb  | Path | Controller#Action | Used for |
| ------------- | ------------- | ------------- | ------------- |
GET | /pages | pages#index    | display a list of all pages
GET | /pages/new | pages#new  | return an HTML form for creating a new page
POST| /pages | pages#create   | create a new page
GET | /pages/:id | pages#show | display a specific page
GET | /pages/:id/edit    |pages#edit |return an HTML form for editing a page
PATCH/PUT |  /pages/:id | pages#update   | update a specific page
DELETE | /pages/:id | pages#destroy  | delete a specific page

</br>
Using the ' resource ' key word instead will create 6 routes without the index action. </br>
</br>

```ruby
resource :page
```

| HTTP Verb  | Path | Controller#Action | Used for |
| ------------- | ------------- | ------------- | ------------- |
GET | /page/new   | pages#new   | return an HTML form for creating the page
POST  | /page   | pages#create    | create the new page
GET | /page   | pages#show  | display the one and only page resource
GET | /page/edit  | pages#edit  | return an HTML form for editing the page
PATCH/PUT   | /page   | pages#update    | update the one and only page resource
DELETE  | /page   | pages#destroy   | delete the page resource

</br>

This might seem like a 'gimmick' when looking at it only with the context of routes but there are further implications when choosing between whether to use 'resources' or 'resource' when dealing with model objects.

regardless of whether you choose 'resources' or 'resource' both singular and plural routes will be mapped to the same controller 'PagesController'.

If you are struggling to decide on which of these to use for your routes - a rule of thumb could be be to first conclude whether the entity you are defing the routes for is plural(many entities of the same kind) or a singular entity. If it's a plural entity go with ' resources ' and if it is a singular entity, go with 'resource'.

In our case the first thing we would want in a project is a home page or a ' landing page ' which is a singular entity. Hence we will be defining the route to our home page as follows.

```ruby
  root to: "homepages#show"
   resource :homepage
```

#### Restricting the Routes created.

Currently we are only using one route of the 6 created for us. This is not very efficient. let's see how we can restrict the routes created using the following iteration to our routes.rb file.

```ruby
  root to: "homepages#show"
   resource :homepage  , only: [:show]
```

Now observe how there is only one defined route for 'homepages' in your web application by using the 'rails routes' command on your terminal.

You can also use the keyword ' except: ' to restrict the created routes.
follow this [link](https://guides.rubyonrails.org/routing.html#restricting-the-routes-created) to the 'Rails Doc' section to study more on this topic.

"If your application has many RESTful routes, using :only and :except to generate only the routes that you actually need can cut down on memory use and speed up the routing process."

#### Adding more actions to resourceful routes

Observe our code in 'App Base' in session 1 and see how we have the actions; apps and contacts which are responsible for handling requests to the 'Our Apps' page and 'Contact Us' page respectively.

We add them to our resource routes collection using the following coding pattern.

```ruby
resource :homepage  , only: [:show] do
  collection do
    get 'apps'
    get 'contacts'
  end
end
```

Now Rails router will recognize the paths 'homepage/apps' and 'homepage/contacts' and will map them to the appropriate controller action.

#### More ways to Customize resourceful routes.

You will find more ways to customize your resourceful routes in the Rails Docs. 

Refer to this [link](https://guides.rubyonrails.org/routing.html#customizing-resourceful-routes) for further study.


### Non-Resourceful routes

-as per the official Rails Documentation.

" In addition to resource routing, Rails has powerful support for routing arbitrary URLs to actions. Here, you don't get groups of routes automatically generated by resourceful routing. Instead, you set up each route separately within your application.

While you should usually use resourceful routing, there are still many places where the simpler routing is more appropriate. There's no need to try to shoehorn every last piece of your application into a resourceful framework if that's not a good fit." 

#### Syntax for defining a Non-Resourceful route.

There are two common syntax patterns when defining routes, both with the same functional output. It's a matter of preference which you choose to go with.

lets define the routes for our 3 apps ; acronym maker , image  finder , Blackjack.

```ruby
get 'acronyms/app', to: 'acronyms#app'
get 'imagefinder/app', to: 'imagefinder#app'
get 'blackjack/app', to: 'blackjack#app'
```

or

```ruby
 get 'acronyms/app'=> 'acronyms#app' 
 get 'imagefinder/app'=> 'imagefinder#app' 
 get 'blackjack/app' => 'blackjack#app'
 ```

 #### Matching Routes to HTTP methods

 Unlike resourceful routing where most routes are created for us corresponding to different http methods. we need to define routes for  get, post, put, patch, and delete methods individually. This can get repetitive and may not yield the cleanest code. So we can use the 'match' method with the :via option to match multiple verbs at once:

 ```ruby
 match 'acronyms/app', to: 'acronyms#app', via: [:get, :post]
 ```

 you can also match to all of the existing http methods using via: :all:

 ```ruby
 match 'acronyms/app', to: 'acronyms#app', via: :all
 ```


 ## Naming Routes

 We can name a Routes using the keyword ' as: ' .

 - Naming Non-Resourceful routes

```ruby
get 'acronyms/app', to: 'acronyms#app' , as: :given_name
```

 - Naming Resourceful routes

```ruby
root 'homepages#show'
 resource :homepage  , only: [:show] , as: :home do 
    collection do
      get 'apps'
      get 'contacts'
    end
  end
```

What this effectively does is change the path name to ' home '. Where earlier it was
{homepages_path , apps_homepages_path , contacts_homepage_path} now these path helpers will be replaced with {home_path , apps_home_path , contacts_home_path} .

## Route Globbing and Wildcard segments.

What if we wanted all paths after home/apps to be routed to a specific controller action. This would mean -> home/apps/stereo | home/apps/123 | home/apps/123/grece | home/apps/wjbfehfb/ehfdwjhef/dw -> all will route to a specified controller action.

```ruby
get 'home/apps/*any', to: 'homepages#show'
```

You can find more information on this functionality [here](https://guides.rubyonrails.org/routing.html#route-globbing-and-wildcard-segments).

## Redirecting requests

We can redirect an incoming request for a given path into a different path using the following syntax

get '/unknown', to: redirect('/home')

You can find more information on this functionality [here](https://guides.rubyonrails.org/routing.html#redirection). 

This is an extremely useful feature when dealing with legacy links as well as when developers move assets to different end points without the knowledge of earlier clients who might still be trying to access an obsolete path.

## Controller Namespacing

Say for instance we wanted to group all our ' apps ' {acronym , imagefinder , blackjack} into one separate folder. This might be necessary if we have many apps and we needed to organize our controller accordingly.

This can be achieved through namespacing,

- First we define our routes under the chosen namespace. let's use the name ' apps ' and put all three controllers into folder names apps. Then in routes.rb

```ruby
namespace :apps do
 get 'acronyms/app'=> 'acronyms#app' 
 get 'imagefinder/app'=> 'imagefinder#app' 
 get 'blackjack/app' => 'blackjack#app'
end
```

- prefix all three controller classes with the ' Apps:: ' namespace. The below example is for the acronyms controller.

```ruby
class Apps::AcronymsController < ApplicationController
```

- Finally add all relevant folders in ' views ' into a new folder named ' apps '

Observe the fruits of our labor by typing in http://localhost:3000/apps/acronyms/app into the browser.