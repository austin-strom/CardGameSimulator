# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Pile.create!(name: "Deck", private_pile: true, creator: nil)
Card.create([{name: "Ace of Spades", pile_id: 1, unicode_value: ""},
             {name: "Two of Spades", pile_id: 1, unicode_value: ""},
             {name: "Three of Spades", pile_id: 1, unicode_value: ""},
             {name: "Four of Spades", pile_id: 1, unicode_value: ""},
             {name: "Five of Spades", pile_id: 1, unicode_value: ""},
             {name: "Six of Spades", pile_id: 1, unicode_value: ""},
             {name: "Seven of Spades", pile_id: 1, unicode_value: ""},
             {name: "Eight of Spades", pile_id: 1, unicode_value: ""},
             {name: "Nine of Spades", pile_id: 1, unicode_value: ""},
             {name: "Ten of Spades", pile_id: 1, unicode_value: ""},
             {name: "Jack of Spades", pile_id: 1, unicode_value: ""},
             {name: "Queen of Spades", pile_id: 1, unicode_value: ""},
             {name: "King of Spades", pile_id: 1, unicode_value: ""},
             {name: "Ace of Hearts", pile_id: 1, unicode_value: ""},
             {name: "Two of Hearts", pile_id: 1, unicode_value: ""},
             {name: "Three of Hearts", pile_id: 1, unicode_value: ""},
             {name: "Four of Hearts", pile_id: 1,unicode_value: ""},
             {name: "Five of Hearts", pile_id: 1, unicode_value: ""},
             {name: "Six of Hearts", pile_id: 1, unicode_value: ""},
             {name: "Seven of Hearts", pile_id: 1, unicode_value: ""},
             {name: "Eight of Hearts", pile_id: 1, unicode_value: ""},
             {name: "Nine of Hearts", pile_id: 1, unicode_value: ""},
             {name: "Ten of Hearts", pile_id: 1, unicode_value: ""},
             {name: "Jack of Hearts", pile_id: 1, unicode_value: ""},
             {name: "Queen of Hearts", pile_id: 1, unicode_value: ""},
             {name: "King of Hearts", pile_id: 1, unicode_value: ""},
             {name: "Ace of Clubs", pile_id: 1, unicode_value: ""},
             {name: "Two of Clubs", pile_id: 1, unicode_value: ""},
             {name: "Three of Clubs", pile_id: 1, unicode_value: ""},
             {name: "Four of Clubs", pile_id: 1, unicode_value: ""},
             {name: "Five of Clubs", pile_id: 1, unicode_value: ""},
             {name: "Six of Clubs", pile_id: 1, unicode_value: ""},
             {name: "Seven of Clubs", pile_id: 1, unicode_value: ""},
             {name: "Eight of Clubs", pile_id: 1, unicode_value: ""},
             {name: "Nine of Clubs", pile_id: 1, unicode_value: ""},
             {name: "Ten of Clubs", pile_id: 1, unicode_value: ""},
             {name: "Jack of Clubs", pile_id: 1, unicode_value: ""},
             {name: "Queen of Clubs", pile_id: 1, unicode_value: ""},
             {name: "King of Clubs", pile_id: 1, unicode_value: ""},
             {name: "Ace of Diamonds", pile_id: 1, unicode_value: ""},
             {name: "Two of Diamonds", pile_id: 1, unicode_value: ""},
             {name: "Three of Diamonds", pile_id: 1, unicode_value: ""},
             {name: "Four of Diamonds", pile_id: 1, unicode_value: ""},
             {name: "Five of Diamonds", pile_id: 1, unicode_value: ""},
             {name: "Six of Diamonds", pile_id: 1, unicode_value: ""},
             {name: "Seven of Diamonds", pile_id: 1, unicode_value: ""},
             {name: "Eight of Diamonds", pile_id: 1, unicode_value: ""},
             {name: "Nine of Diamonds", pile_id: 1, unicode_value: ""},
             {name: "Ten of Diamonds", pile_id: 1, unicode_value: ""},
             {name: "Jack of Diamonds", pile_id: 1, unicode_value: ""},
             {name: "Queen of Diamonds", pile_id: 1, unicode_value: ""},
             {name: "King of Diamonds", pile_id: 1, unicode_value: ""}
])
