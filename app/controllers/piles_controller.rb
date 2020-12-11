class PilesController < ApplicationController
  before_action :set_current_user
  protect_from_forgery with: :null_session

  def pile_params
    params.require(:pile).permit(:name, :private_pile, :creator, :source_pile_id, :destination_pile_id)
  end

  def index
    @piles = Pile.all
  end

  def new
    render(partial: 'partials/create_pile') if request.xhr?
  end

  def new_deck
  end

  def create_deck
    #room_id = params[:room_id]
    room = Room.find_by(id: params[:room_id])
    @pile = Pile.create!(name: "Deck", creator: "The Game", private_pile: true, card_count: 52, room_id: params[:room_id])
    room.piles << @pile
    Card.create([{name: "Ace of Spades", pile_id: @pile.id},
                 {name: "Two of Spades", pile_id: @pile.id},
                 {name: "Three of Spades", pile_id: @pile.id},
                 {name: "Four of Spades", pile_id: @pile.id},
                 {name: "Five of Spades", pile_id: @pile.id},
                 {name: "Six of Spades", pile_id: @pile.id},
                 {name: "Seven of Spades", pile_id: @pile.id},
                 {name: "Eight of Spades", pile_id: @pile.id},
                 {name: "Nine of Spades", pile_id: @pile.id},
                 {name: "Ten of Spades", pile_id: @pile.id},
                 {name: "Jack of Spades", pile_id: @pile.id},
                 {name: "Queen of Spades", pile_id: @pile.id},
                 {name: "King of Spades", pile_id: @pile.id},
                 {name: "Ace of Hearts", pile_id: @pile.id},
                 {name: "Two of Hearts", pile_id: @pile.id},
                 {name: "Three of Hearts", pile_id: @pile.id},
                 {name: "Four of Hearts", pile_id: @pile.id},
                 {name: "Five of Hearts", pile_id: @pile.id},
                 {name: "Six of Hearts", pile_id: @pile.id},
                 {name: "Seven of Hearts", pile_id: @pile.id},
                 {name: "Eight of Hearts", pile_id: @pile.id},
                 {name: "Nine of Hearts", pile_id: @pile.id},
                 {name: "Ten of Hearts", pile_id: @pile.id},
                 {name: "Jack of Hearts", pile_id: @pile.id},
                 {name: "Queen of Hearts", pile_id: @pile.id},
                 {name: "King of Hearts", pile_id: @pile.id},
                 {name: "Ace of Clubs", pile_id: @pile.id},
                 {name: "Two of Clubs", pile_id: @pile.id},
                 {name: "Three of Clubs", pile_id: @pile.id},
                 {name: "Four of Clubs", pile_id: @pile.id},
                 {name: "Five of Clubs", pile_id: @pile.id},
                 {name: "Six of Clubs", pile_id: @pile.id},
                 {name: "Seven of Clubs", pile_id: @pile.id},
                 {name: "Eight of Clubs", pile_id: @pile.id},
                 {name: "Nine of Clubs", pile_id: @pile.id},
                 {name: "Ten of Clubs", pile_id: @pile.id},
                 {name: "Jack of Clubs", pile_id: @pile.id},
                 {name: "Queen of Clubs", pile_id: @pile.id},
                 {name: "King of Clubs", pile_id: @pile.id},
                 {name: "Ace of Diamonds", pile_id: @pile.id},
                 {name: "Two of Diamonds", pile_id: @pile.id},
                 {name: "Three of Diamonds", pile_id: @pile.id},
                 {name: "Four of Diamonds", pile_id: @pile.id},
                 {name: "Five of Diamonds", pile_id: @pile.id},
                 {name: "Six of Diamonds", pile_id: @pile.id},
                 {name: "Seven of Diamonds", pile_id: @pile.id},
                 {name: "Eight of Diamonds", pile_id: @pile.id},
                 {name: "Nine of Diamonds", pile_id: @pile.id},
                 {name: "Ten of Diamonds", pile_id: @pile.id},
                 {name: "Jack of Diamonds", pile_id: @pile.id},
                 {name: "Queen of Diamonds", pile_id: @pile.id},
                 {name: "King of Diamonds", pile_id: @pile.id}
                ])
    room.save!

    # flash[:notice] = "Another deck added to the room"
    redirect_to room_path({:id => params[:room_id]}), flash: { notice: "Another deck added to the room"} and return
  end

  def create
    #room_id = params[:room_id]
    room = Room.find_by(id: params[:room_id])
    private_pile = params[:private_pile]
    #name = params[:pile][:name]
    #creator = params[:pile][:creator]
    @pile = Pile.create!(name: params[:pile][:name], creator: params[:pile][:creator], private_pile: private_pile, card_count: 0, room_id: params[:room_id])
    room.piles << @pile
    room.save!
    redirect_to room_path({:id => params[:room_id]}), flash: { notice: "#{@pile.name} was successfully created."}
    #flash[:notice] = "#{@pile.name} was successfully created." #@pile.name
    # redirect_to room_path({:id => room_id}) and return
  end

  def show_transfer
    @piles = Room.find_by_id(params[:room_id]).piles
    render(partial: 'partials/transfer_cards') if request.xhr?
  end

  def draw_cards_from_deck
    num_cards = params[:pile][:num_cards].to_i
    deck = Pile.find_by(name: "Deck", room_id: params[:room_id])
    destination_pile = Pile.find_by(name: "#{@current_user.user_id}'s Hand", room_id: params[:room_id]) #this represents the format an automatically created hand should get
    if num_cards > deck.cards.count
      redirect_to room_path({:id => params[:room_id]}), flash: { notice: 'There are not enough cards in the deck. Please try again or wait until the deck is replenished.'} and return
    end
    deck_count = deck.cards.count
    list_of_cards = (0...deck_count-1).to_a.sample(num_cards)
    list_of_cards.each do |card_num|
      destination_pile.cards << deck.cards[card_num]
      destination_pile[:card_count] = destination_pile[:card_count] + 1
      deck[:card_count] = deck[:card_count] - 1
      deck.save
      destination_pile.save
    end
    redirect_to room_path({:id => params[:room_id]}), flash: { notice: "#{num_cards} card(s) transferred from Deck!"} and return
  end

  def transfer_card
    begin
      source_pile = Pile.find pile_params[:source_pile_id]
      destination_pile = Pile.find pile_params[:destination_pile_id]
    rescue ActiveRecord::RecordNotFound
      redirect_to room_path({:id => params[:room_id]}) and return
    end
    if params[:the_cards].nil?
      redirect_to room_path({:id => params[:room_id]}) and return
    end
    Pile.transfer(source_pile, destination_pile, params[:the_cards])
  end

  def get_from_draw
    @room = Room.find_by(id: params[:room_id])
    render(partial: 'partials/draw_card') if request.xhr?
  end

  def discard
    @player_pile = Pile.find_by(name: "#{@current_user.user_id}'s Hand", room_id: params[:room_id])
    @thecards = @player_pile.cards
    render(partial: 'partials/discard_cardy') if request.xhr? and return
  end

  def transfer_to_discard
    source_pile = Pile.find_by(name: params[:source_pile_name], room_id: params[:room_id])
    @destination_pile = Pile.find_by(name: params[:pile][:name2], room_id: params[:room_id])
    if @destination_pile.nil?
      redirect_to room_path({:id => params[:room_id]}), flash: { notice: "(transfer_card) This is not a pile in the database. Please try again."} and return #piles_pile_homepage_path and return
    end
    if params[:the_cards].nil?
      redirect_to room_path({:id => params[:room_id]}), flash: { notice: "No cards selected"} and return
    end
    Pile.transfer source_pile, @destination_pile, params[:the_cards]
    redirect_to room_path({:id => params[:room_id]}), flash: { notice: "Card(s) successfully discarded!"}
  end

end
