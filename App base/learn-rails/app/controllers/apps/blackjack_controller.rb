  
class Apps::BlackjackController < ApplicationController
    
    def app
        if (session[:deck_id] == nil) 
            response = Faraday.get("https://deckofcardsapi.com/api/deck/new/shuffle/?deck_count=1")
            json = JSON.parse(response.body)
            session[:deck_id] = json["deck_id"]

            session[:playercards] = draw_two(session[:deck_id])
            session[:compcards] = draw_one(session[:deck_id])
        end
        
        if (session[:deck_id] != nil)    
            @total_player = get_total(session[:playercards])
            @total_computer = get_total(session[:compcards])
        end

        if (params[:hit]) then hit end
        if (params[:restart]) then restart end
        if (params[:stay]) then comps_turn end

        
    end

    private

    def draw_two(deck_id)
        response = Faraday.get("https://deckofcardsapi.com/api/deck/#{deck_id}/draw/?count=2")
        json = JSON.parse(response.body)
        cards = json["cards"]
    end

    def draw_one(deck_id)
        response = Faraday.get("https://deckofcardsapi.com/api/deck/#{deck_id}/draw/?count=1")
        json = JSON.parse(response.body)
        cards = json["cards"]
    end

    def get_value(card)
        case card
        when "KING", "QUEEN", "JACK"
            value=10
        when "ACE"
            value=11
        else
            value=card.to_i
        end
    end

    def get_total(cards)
        total = 0
        cards.each do |card|
            total += get_value(card["value"])
        end
        return total
    end
    
    def hit   
        new_card = draw_one(session[:deck_id])
        session[:playercards].push(new_card[0])
        @total_player = get_total(session[:playercards])
    end

    def restart
        session[:playercards] = nil
        session[:compcards] = nil
        session[:deck_id] = nil
        redirect_to action: "app"
    end

    def comps_turn
        while @total_computer < 17 do
            card = draw_one(session[:deck_id])
            session[:compcards].push(card[0])
            @total_computer = get_total(session[:compcards])
        end
        outcome
    end

    def outcome
        if @total_player > @total_computer
            @outcome = "You Win!"
        elsif @total_player < @total_computer
            @outcome = "You Lose!"
        else
            @outcome = "Draw!"
        end
    end
end