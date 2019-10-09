// rough draft made by meetup members on 10/7/19

pragma solidity ^0.5.1;

// prisioner's dilemma
contract Tekashi69_Dilemma {
    // the suspects' choices 
    // hack to name sure pending is 0 which is a default value
    enum Choice { NULL, PENDING, SILENCE, SNITCH }
    
    address suspect1;
    address suspect2;
    
    // doesn't have to specify where its use before the constructor
    // each suspect can make a choice
    mapping(address => Choice) suspectChoices;

    constructor(address suspect1, address suspect2) public {
        suspect1 = suspect1;
        suspect2 = suspect2;
        suspectChoices[suspect1] = Choice.PENDING;
        suspectChoices[suspect2] = Choice.PENDING;
    }

    // the suspect makes a decision
    function suspectDecision(Choice choice) public {
        // suspects can only decide
        // you can still make a decsion
        require(suspectChoices[msg.sender] == Choice.PENDING);
        require(isValid(choice));

        // make a choice!
        suspectChoices[msg.sender] = choice;
        
        // prosecutor giggles and runs verdict()
        verdict();
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
    function isValid(Choice choice) internal pure returns (bool) {
        // prosecutor pressures you to make choice, 
        // can't choose pending to stall or Denial of service
        return choice == Choice.SILENCE || choice == Choice.SNITCH;
    }
    
    function interrogated(address suspect) internal view returns (bool) {
        return isValid(suspectChoices[suspect]);
    }
    
}

/*
To improve:
- create struct for players and remove hack in enum.
- send enough ETH early on and get a lawyer
- Run out of ETH make a decision.
- add aztec protocol to hide decision, other guy could just see the decision.


It's a game.

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
