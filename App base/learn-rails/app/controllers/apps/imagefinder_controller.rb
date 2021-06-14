  
class Apps::ImagefinderController < ApplicationController
  def app
    if params[:keywords].present?
      @keywords = params[:keywords]
      @keywords2 = @keywords.split
      @keywords3 = ""
      n = 0
      @keywords2.each do |i|
        @keywords3 += i
        n += 1
        break if n == @keywords2.length
        @keywords3 += ", "
      end
    else
      @keywords3 = ""
    end
  end
end
