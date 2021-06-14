class Apps::AcronymsController < ApplicationController

def app
  @result = ""

  if params[:phrase].present?
  
  @result = (params[:phrase].split(/[\s ,\-,\,]/).map{ |x| x[0].capitalize unless x[0] == nil })#.join
  @result = (@result.map {|word| word << "."}).join

  end


end

end
