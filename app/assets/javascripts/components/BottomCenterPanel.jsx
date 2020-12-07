import React from "react";
// import Card from "react-playing-card"
import {Button} from "react-bootstrap";
import '../../stylesheets/cards.css';
import '../../stylesheets/cards-ie.css';
import '../../stylesheets/cards-ie9.css';

export default class BottomCenterPanel extends React.Component{
    constructor(props) {
        super(props);
        this._render_hand = this._render_hand.bind(this);
    }

    _render_hand = function (cardList){
        const cards = cardList.map((card, idx) => {
            if(card === "Flipped"){
                return <div className="card back" />
            } else {
                let rank = card[0]
                let suit = card.substring(1);
                let suit_ascii = '&' + suit + ';'
                return(
                    <div className={"card rank-" + rank + " " + suit}>
                        <div className="rank">{rank.toUpperCase()}</div>
                        <div className="suit">&{suit};</div>
                    </div>);
            }
        })

        return(<div className="playingCards faceImages">{cards}</div>)
    }

    render() {
        var cardList = ["ahearts", "2diams", "3spades", "Flipped", "8hearts", "qspades", "kspades"]
        return(
            <React.Fragment>
                {this._render_hand(cardList)}
                {/*<Button variant="outline-primary" className="blank-card">+</Button>*/}
                {/*<Button variant="outline-primary" className="blank-card">+</Button>*/}
                {/*<Button variant="outline-primary" className="blank-card">+</Button>*/}
                {/*<Button variant="outline-primary" className="blank-card">+</Button>*/}
                {/*<Button variant="outline-primary" className="blank-card">+</Button>*/}
            </React.Fragment>
        )
    }
}