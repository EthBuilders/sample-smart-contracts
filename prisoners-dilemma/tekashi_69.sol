// rough draft made by meetup members on 10/7/19

pragma solidity ^0.5.1;

// prisioner's dilemma
contract Tekashi69_Dilemma {
    // the suspects' choices 
    // hack to name sure pending is 0 which is a default value
    enum Choices { _AvoidZero, pending, silence, snitch }
    
    address suspect1;
    address suspect2;
    
    // doesn't have to specify where its use before the constructor
    // each suspect can make a choice
    mapping(address => Choices) suspectChoice;
    constructor(address suspect1, address suspect2) public {
        suspect1 = suspect1;
        suspect2 = suspect2;
        suspectChoice[suspect1] = Choices.pending;
        suspectChoice[suspect2] = Choices.pending;
    }

    // the suspect makes a decision
    function suspectDecision(Choices choice) public {
        // suspects can only decide
        // you can still make a decsion
        require(suspectChoice[msg.sender] == Choices.pending);
        require(isValid(choice));

        // make a choice!
        suspectChoice[msg.sender] = choice;
        
        // prosecutor giggles and runs verdict()
        verdict()
    }
    
    // final deal
    function verdict() internal {
        // check if there are not pending
        // did the other guy make the choice?
        // if so, we have a verdict
        // if we use require() the function gets killed, no error handling
        if (interrogated(suspect1) && interrogated(suspect2)) {
            // assign sentences to suspects
        } else {
            // other guy needs to make decision
        }
    }
    
    // domain driven design
    function isValid(Choices choice) internal pure returns (bool) {
        // prosecutor pressures you to make choice, 
        // can't choose pending to stall or Denial of service
        return choice == Choices.silence || choice == Choices.snitch;
    }
    
    function interrogated(address suspect) internal returns (bool) {
        return isValid(suspectChoice[suspect]);
    }
    
}

/*
To improve:
- create struct for players and remove hack in enum.
- send enough ETH early on and get a lawyer
- Run out of ETH make a decision.
- add aztec protocol to hide decision, other guy could just see the decision.


Its game.

two players -> two addresses


Logic:
What the point: would rational person would trust?
From math perspective, its rational to betray

decision()
    happens one at a time.
    order doesn't matter, just needs to happen.
    
    betray:
        If one A rats out the B: A: 0, B:3
        If one B rats out the A: A: 3, B:0
        Both A and B: A: 2, B: 2
    
    cooperate:
        If A and B stay silent: A: 1, B: 1
    
*/